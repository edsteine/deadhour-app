import 'package:flutter/material.dart';




class SocialExperiencesTab extends StatelessWidget {
  final List<Map<String, dynamic>> filteredExperiences;
  final List<Map<String, dynamic>> socialInterests;

  const SocialExperiencesTab({
    super.key,
    required this.filteredExperiences,
    required this.socialInterests,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialStatsHeader(experiencesCount: filteredExperiences.length),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredExperiences.length,
            itemBuilder: (context, index) {
              return ExperienceCard(
                experience: filteredExperiences[index],
                socialInterests: socialInterests,
                onViewDetails: (exp) =>
                    SocialActionHelpers.viewExperienceDetails(context, exp),
                onContactHost: (exp) =>
                    SocialActionHelpers.contactHost(context, exp),
                onJoinExperience: (exp) =>
                    SocialActionHelpers.joinExperience(context, exp),
              );
            },
          ),
        ),
      ],
    );
  }
}
