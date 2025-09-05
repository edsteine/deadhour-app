# DeadHour Project - Claude Configuration

## 🚨 CRITICAL: File Safety Rules 🚨
**NEVER USE: rm, rm -rf, rm -r, OR ANY DELETION COMMANDS**  
**ALWAYS USE: mv filename /Users/mac/Desktop/deadhour-app/trash/**

## Project Context

**DeadHour** is a dual-problem platform for Morocco:
1. **Business Revenue Optimization**: Fill empty venues during "dead hours"
2. **Social Discovery**: Community-driven deal validation and booking

**Multi-Role Account System** (critical architecture):
- **Consumer** (Free): Browse deals, community participation
- **Business** (€30/month): Post deals, analytics, dead hours optimization  
- **Premium** (€15/month): Enhanced features across all roles

**Market**: 300K+ businesses, 8M+ locals in Morocco (V1 focus)

## User Working Methodology

**File-by-File Systematic Approach** (MANDATORY):
- Process ONE file at a time completely before moving to next
- Read → Understand → Act → Verify → Document → Next
- Take time, be methodical, no rushing ("don't be the flash barry")
- Always preserve ALL user work - this is their personal project
- Ask "Ready for next file?" before proceeding to new files

## Core Technical Rules

### Flutter Development
- **State Management**: flutter_riverpod (migrating from provider)
- **Naming**: Use "Role" terminology (NEVER "ADDON")
- **Mock Data**: Use lib/utils/mock_data.dart until Firebase integration
- **Local Integration**: Business timing, quality food filtering, local language responsive support

### Code Quality (MANDATORY)
```bash
flutter analyze     # After every change
dart fix --apply    # Auto-fix issues
```
Never leave linting issues unresolved.

### Deprecated API Replacements
- ❌ `color.withOpacity(0.5)` 
- ✅ `color.withValues(alpha: 0.5)`

### App Execution (FORBIDDEN)
Never run: `flutter run`, `flutter build apk`, `flutter build ios`, `flutter build web`

## Morocco Cultural Requirements
- **Prayer Times**: 5 daily prayers integration
- **Ramadan Mode**: Suhoor/Iftar scheduling
- **Halal Certification**: Complete filtering system
- **Multi-Language**: Arabic RTL + French + English
- **Currency**: MAD primary, EUR for tourists

## Code Preservation Rule
**NEVER delete ANY existing code**. Instead:
- Find ways to USE unused methods by connecting to UI
- Add buttons/menu items to make code functional
- Integrate unused functionality into interface
- Fix linters by making code useful, not by deleting it

## TODO.md Compliance
- Always check TODO.md before starting work
- Follow priority order: Critical → High → Medium  
- Update progress as files completed
- TODO.md is single source of truth for tasks

## Revenue Model
- Multi-role subscriptions: €65+/month per user potential
- Booking commissions: 8-15% on off-peak deals
- Network effects: Community validation drives bookings
- Target: €60-65 average revenue per user

## AI Role Division
- **Claude (You)**: Implementation, architecture, code execution
- **Gemini**: Research, analysis, strategy, market intelligence  
- **Human**: Vision, direction, quality control, decisions

## Communication Style
- Be systematic and methodical
- Preserve all user work (they're autistic, excel in coding)
- Follow file-by-file approach they prefer
- Wait for approval between major file operations
- Focus on implementation excellence

## Current Phase
MVP development with mock data, hidden monetization, Morocco cultural integration, multi-role architecture ready for community-driven deal discovery.