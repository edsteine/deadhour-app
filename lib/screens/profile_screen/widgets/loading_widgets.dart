import 'package:flutter/material.dart';



// Skeleton Loading Widgets for DeadHour App
class LoadingWidgets {
  // Skeleton for deal cards
  static Widget buildDealCardSkeleton() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildShimmerBox(40, 40, borderRadius: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBox(120, 16),
                      const SizedBox(height: 4),
                      _buildShimmerBox(80, 12),
                    ],
                  ),
                ),
                _buildShimmerBox(60, 24, borderRadius: 12),
              ],
            ),
            const SizedBox(height: 12),
            _buildShimmerBox(double.infinity, 16),
            const SizedBox(height: 8),
            _buildShimmerBox(200, 12),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShimmerBox(80, 20),
                _buildShimmerBox(100, 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Skeleton for venue cards
  static Widget buildVenueCardSkeleton() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerBox(double.infinity, 120),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerBox(150, 18),
                const SizedBox(height: 8),
                _buildShimmerBox(double.infinity, 14),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildShimmerBox(60, 12),
                    const SizedBox(width: 16),
                    _buildShimmerBox(80, 12),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Skeleton for room cards
  static Widget buildRoomCardSkeleton() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildShimmerBox(50, 50, borderRadius: 25),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBox(120, 16),
                      const SizedBox(height: 4),
                      _buildShimmerBox(200, 12),
                    ],
                  ),
                ),
                _buildShimmerBox(40, 16),
              ],
            ),
            const SizedBox(height: 12),
            _buildShimmerBox(double.infinity, 14),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildShimmerBox(80, 12),
                const SizedBox(width: 16),
                _buildShimmerBox(100, 12),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Skeleton for experience cards
  static Widget buildExperienceCardSkeleton() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShimmerBox(250, 100),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerBox(150, 14),
                  const SizedBox(height: 4),
                  _buildShimmerBox(200, 12),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildShimmerBox(50, 12),
                      const SizedBox(width: 8),
                      _buildShimmerBox(60, 12),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Skeleton for profile header
  static Widget buildProfileHeaderSkeleton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildShimmerBox(80, 80, borderRadius: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerBox(120, 18),
                const SizedBox(height: 4),
                _buildShimmerBox(80, 14),
                const SizedBox(height: 8),
                _buildShimmerBox(100, 12),
              ],
            ),
          ),
          _buildShimmerBox(30, 30, borderRadius: 15),
        ],
      ),
    );
  }

  // List skeleton builders
  static Widget buildDealListSkeleton({int itemCount = 5}) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => buildDealCardSkeleton(),
    );
  }

  static Widget buildVenueListSkeleton({int itemCount = 3}) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => buildVenueCardSkeleton(),
    );
  }

  static Widget buildRoomListSkeleton({int itemCount = 4}) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => buildRoomCardSkeleton(),
    );
  }

  static Widget buildExperienceListSkeleton({int itemCount = 3}) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) => buildExperienceCardSkeleton(),
      ),
    );
  }

  // Loading states for different screens
  static Widget buildHomeScreenSkeleton() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Category filter skeleton
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                width: 80,
                margin: const EdgeInsets.only(right: 8),
                child: _buildShimmerBox(80, 40, borderRadius: 20),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildShimmerBox(120, 20),
                const Spacer(),
                _buildShimmerBox(60, 16),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Deal cards
          ...List.generate(3, (index) => buildDealCardSkeleton()),

          const SizedBox(height: 16),

          // Another section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildShimmerBox(150, 20),
          ),
          const SizedBox(height: 16),

          // Venue cards
          ...List.generate(2, (index) => buildVenueCardSkeleton()),
        ],
      ),
    );
  }

  static Widget buildCommunityScreenSkeleton() {
    return Column(
      children: [
        // Filter section
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildShimmerBox(100, 16),
              const Spacer(),
              _buildShimmerBox(80, 32, borderRadius: 16),
            ],
          ),
        ),

        // Room list
        Expanded(
          child: buildRoomListSkeleton(itemCount: 6),
        ),
      ],
    );
  }

  static Widget buildTourismScreenSkeleton() {
    return Column(
      children: [
        // Welcome banner skeleton
        Container(
          height: 120,
          margin: const EdgeInsets.all(16),
          child: _buildShimmerBox(double.infinity, 120, borderRadius: 12),
        ),

        // Tab bar skeleton
        SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              4,
              (index) => _buildShimmerBox(80, 20),
            ),
          ),
        ),

        // Content skeleton
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                buildExperienceListSkeleton(),
                const SizedBox(height: 24),
                ...List.generate(3, (index) => buildVenueCardSkeleton()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Base shimmer box widget
  static Widget _buildShimmerBox(double width, double height,
      {double borderRadius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const ShimmerEffect(),
    );
  }
}


