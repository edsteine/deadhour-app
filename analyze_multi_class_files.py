#!/usr/bin/env python3
"""
Script to analyze Dart files and identify those with multiple classes, enums, or other declarations.
This helps identify files that need to be split into separate files to avoid naming conflicts.
"""

import os
import re
from pathlib import Path
from typing import List, Dict, Tuple, Set

class DartAnalyzer:
    def __init__(self, project_path: str):
        self.project_path = Path(project_path)
        self.lib_path = self.project_path / "lib"
        
    def find_dart_files(self) -> List[Path]:
        """Find all Dart files in the lib directory."""
        dart_files = []
        for root, dirs, files in os.walk(self.lib_path):
            for file in files:
                if file.endswith('.dart'):
                    dart_files.append(Path(root) / file)
        return dart_files
    
    def extract_declarations(self, file_path: Path) -> Dict[str, List[str]]:
        """Extract class, enum, mixin, and typedef declarations from a Dart file."""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except Exception as e:
            print(f"Error reading {file_path}: {e}")
            return {}
        
        declarations = {
            'classes': [],
            'enums': [],
            'mixins': [],
            'typedefs': [],
            'extensions': []
        }
        
        # Remove comments and strings to avoid false matches
        content = self._remove_comments_and_strings(content)
        
        # Patterns for different declarations
        patterns = {
            'classes': r'\bclass\s+([A-Z][a-zA-Z0-9_]*)\b',
            'enums': r'\benum\s+([A-Z][a-zA-Z0-9_]*)\b',
            'mixins': r'\bmixin\s+([A-Z][a-zA-Z0-9_]*)\b',
            'typedefs': r'\btypedef\s+([A-Z][a-zA-Z0-9_]*)\b',
            'extensions': r'\bextension\s+([A-Z][a-zA-Z0-9_]*)\b'
        }
        
        for decl_type, pattern in patterns.items():
            matches = re.findall(pattern, content)
            declarations[decl_type] = matches
            
        return declarations
    
    def _remove_comments_and_strings(self, content: str) -> str:
        """Remove comments and string literals to avoid false matches."""
        # Remove single-line comments
        content = re.sub(r'//.*$', '', content, flags=re.MULTILINE)
        
        # Remove multi-line comments
        content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
        
        # Remove string literals (simplified - handles most cases)
        content = re.sub(r'"[^"\\]*(?:\\.[^"\\]*)*"', '""', content)
        content = re.sub(r"'[^'\\]*(?:\\.[^'\\]*)*'", "''", content)
        
        return content
    
    def is_stateful_widget_pair(self, classes: List[str]) -> bool:
        """Check if the classes are a StatefulWidget pair (Widget + State)."""
        if len(classes) != 2:
            return False
            
        # Sort to have consistent ordering
        sorted_classes = sorted(classes)
        
        # Check if one is the State class of the other
        for class_name in sorted_classes:
            state_name = f"_{class_name}State"
            if state_name in sorted_classes:
                return True
                
        return False
    
    def analyze_files(self) -> Dict[str, Dict]:
        """Analyze all Dart files and return those with multiple declarations."""
        dart_files = self.find_dart_files()
        multi_declaration_files = {}
        
        for file_path in dart_files:
            declarations = self.extract_declarations(file_path)
            
            # Count total declarations
            total_declarations = sum(len(decls) for decls in declarations.values())
            
            if total_declarations > 1:
                # Check if it's just a StatefulWidget pair
                is_widget_pair = (
                    total_declarations == 2 and 
                    len(declarations['classes']) == 2 and
                    self.is_stateful_widget_pair(declarations['classes'])
                )
                
                multi_declaration_files[str(file_path.relative_to(self.project_path))] = {
                    'declarations': declarations,
                    'total_count': total_declarations,
                    'is_widget_pair': is_widget_pair,
                    'needs_splitting': not is_widget_pair
                }
        
        return multi_declaration_files
    
    def generate_report(self) -> str:
        """Generate a detailed report of multi-declaration files."""
        results = self.analyze_files()
        
        report = ["# Multi-Declaration Files Analysis", ""]
        report.append(f"**Analysis Date:** {Path().cwd()}")
        report.append(f"**Total files analyzed:** {len(self.find_dart_files())}")
        report.append(f"**Files with multiple declarations:** {len(results)}")
        report.append("")
        
        # Files that need splitting
        needs_splitting = {k: v for k, v in results.items() if v['needs_splitting']}
        report.append(f"**Files that need splitting:** {len(needs_splitting)}")
        report.append("")
        
        if needs_splitting:
            report.append("## Files That Need Splitting")
            report.append("")
            
            for file_path, info in needs_splitting.items():
                report.append(f"### {file_path}")
                report.append(f"- **Total declarations:** {info['total_count']}")
                
                for decl_type, names in info['declarations'].items():
                    if names:
                        report.append(f"- **{decl_type.title()}:** {', '.join(names)}")
                
                report.append("")
        
        # StatefulWidget pairs (OK to keep together)
        widget_pairs = {k: v for k, v in results.items() if v['is_widget_pair']}
        if widget_pairs:
            report.append("## StatefulWidget Pairs (OK to keep together)")
            report.append("")
            
            for file_path, info in widget_pairs.items():
                classes = info['declarations']['classes']
                report.append(f"- {file_path}: {', '.join(classes)}")
            
            report.append("")
        
        return "\n".join(report)

def main():
    project_path = "/Users/edsteine/Desktop/deadhour-app"
    analyzer = DartAnalyzer(project_path)
    
    print("Analyzing Dart files for multiple declarations...")
    report = analyzer.generate_report()
    
    # Write report to file
    report_path = Path(project_path) / "multi_class_analysis_report.md"
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write(report)
    
    print(f"Analysis complete! Report saved to: {report_path}")
    print("\nSummary:")
    
    results = analyzer.analyze_files()
    needs_splitting = sum(1 for v in results.values() if v['needs_splitting'])
    widget_pairs = sum(1 for v in results.values() if v['is_widget_pair'])
    
    print(f"- Total files with multiple declarations: {len(results)}")
    print(f"- Files that need splitting: {needs_splitting}")
    print(f"- StatefulWidget pairs (OK): {widget_pairs}")

if __name__ == "__main__":
    main()