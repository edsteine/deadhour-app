
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deadhour/utils/app_theme.dart';
import 'package:deadhour/utils/app_colors.dart';

import 'package:deadhour/app.dart';
import 'package:deadhour/main.dart';
import 'package:deadhour/screens/accessibility_settings_screen/accessibility_settings_screen.dart';
import 'package:deadhour/screens/accessibility_settings_screen/services/accessibility_service.dart';
import 'package:deadhour/screens/accessibility_settings_screen/services/accessible_bottom_navigation_bar.dart';
import 'package:deadhour/screens/accessibility_settings_screen/services/accessible_floating_action_button.dart';
import 'package:deadhour/screens/accessibility_settings_screen/services/accessible_tab_bar.dart';
import 'package:deadhour/screens/analytics_dashboard_screen/analytics_dashboard_screen.dart';
import 'package:deadhour/screens/booking_flow_screen/booking_confirmation_dialog.dart';
import 'package:deadhour/screens/booking_flow_screen/booking_flow_screen.dart';
import 'package:deadhour/screens/booking_flow_screen/booking_options_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/confirm_booking_button.dart';
import 'package:deadhour/screens/booking_flow_screen/cultural_timing_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/deal_summary_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/payment_method_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/social_booking_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/special_requests_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/time_selection_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/total_and_sharing_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/business_dashboard_screen.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/analytics_data.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/analytics_events.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/analytics_properties.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/analytics_service.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/deal_suggestion.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/deal_suggestions_service.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/pricing_suggestion.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/ramadan_business_service.dart';
import 'package:deadhour/screens/business_dashboard_screen/utils/business_action_helpers.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_competitor_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_customer_tab_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_demographic_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_feedback_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_kpi_card_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_metric_card_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_peak_hours_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_performance_tab_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_period_selector_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_recommendations_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_revenue_card_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_revenue_source_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_revenue_tab_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_weekly_chart_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/business_header.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/business_tab_bar.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/dead_hours_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_action_buttons.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_capacity_form.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_community_form.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_header.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_information_form.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_schedule_form.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_suggestions_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_type_selection.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deals_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/insights_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/overview_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/pricing_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/professional_action_card.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/professional_card.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/professional_gradient_card.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/professional_stats_card.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/promotions_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/settings_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/time_frame_selector.dart';
import 'package:deadhour/screens/community_health_dashboard_screen/community_health_dashboard_screen.dart';
import 'package:deadhour/screens/create_deal_screen/create_deal_screen.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/application_state.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/cultural_ambassador_application_screen.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/cultural_info_bottom_sheet.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/cultural_timing_widget.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_action_buttons.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_experience_step.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_expertise_step.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_personal_info_step.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_progress_widget.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_review_section.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_review_step.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_success_dialog.dart';
import 'package:deadhour/screens/deals_screen/deals_screen.dart';
import 'package:deadhour/screens/deals_screen/filters/deal_filters_widget.dart';
import 'package:deadhour/screens/deals_screen/filters/deals_filters.dart';
import 'package:deadhour/screens/deals_screen/models/deal.dart';
import 'package:deadhour/screens/deals_screen/services/automatic_deal_service.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_calculation.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_service.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_status.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_summary.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_tier.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_transaction.dart';
import 'package:deadhour/screens/deals_screen/services/community_status.dart';
import 'package:deadhour/screens/deals_screen/services/deal_data.dart';
import 'package:deadhour/screens/deals_screen/services/deal_interaction_service.dart';
import 'package:deadhour/screens/deals_screen/services/deal_photo.dart';
import 'package:deadhour/screens/deals_screen/services/deal_rating.dart';
import 'package:deadhour/screens/deals_screen/services/deal_validation.dart';
import 'package:deadhour/screens/deals_screen/services/deal_validation_service.dart';
import 'package:deadhour/screens/deals_screen/services/tier_requirement.dart';
import 'package:deadhour/screens/deals_screen/services/top_validator.dart';
import 'package:deadhour/screens/deals_screen/services/user_rating.dart';
import 'package:deadhour/screens/deals_screen/services/validation_summary.dart';
import 'package:deadhour/screens/deals_screen/services/validation_type.dart';
import 'package:deadhour/screens/deals_screen/services/withdrawal_method.dart';
import 'package:deadhour/screens/deals_screen/widgets/deal_card.dart';
import 'package:deadhour/screens/deals_screen/widgets/deals_header_widget.dart';
import 'package:deadhour/screens/deals_screen/widgets/deals_list_view.dart';
import 'package:deadhour/screens/deals_screen/widgets/deals_map_view.dart';
import 'package:deadhour/screens/deals_screen/widgets/optimized_list_view.dart';
import 'package:deadhour/screens/dev_menu_screen/dev_menu_prayer_times_widget.dart';
import 'package:deadhour/screens/dev_menu_screen/dev_menu_screen.dart';
import 'package:deadhour/screens/dev_menu_screen/dev_route.dart';
import 'package:deadhour/screens/group_booking_screen/group_booking_screen.dart';
import 'package:deadhour/screens/guide_role_screen/guide_role_screen.dart';
import 'package:deadhour/screens/home_screen/home_screen.dart';
import 'package:deadhour/screens/local_expert_screen/local_expert_screen.dart';
import 'package:deadhour/screens/login_screen/login_screen.dart';
import 'package:deadhour/screens/main_navigation_screen/main_navigation_screen.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_app_bars.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_controller.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_dialogs.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_item.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_items.dart';
import 'package:deadhour/screens/network_effects_dashboard_screen/network_effects_dashboard_screen.dart';
import 'package:deadhour/screens/notifications_screen/notification_badge_widget.dart';
import 'package:deadhour/screens/notifications_screen/notifications_bottom_sheet.dart';
import 'package:deadhour/screens/notifications_screen/notifications_screen.dart';
import 'package:deadhour/screens/notifications_screen/services/digest_item.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_action.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_digest.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_frequency.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_group.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_interaction.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_service.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_suggested_action.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_summary.dart';
import 'package:deadhour/screens/notifications_screen/services/smart_notification.dart';
import 'package:deadhour/screens/notifications_screen/services/smart_notification_service.dart';
import 'package:deadhour/screens/notifications_screen/services/user_notification_preferences.dart';
import 'package:deadhour/screens/notifications_screen/utils/notification_helpers.dart';
import 'package:deadhour/screens/notifications_screen/widgets/empty_state.dart';
import 'package:deadhour/screens/notifications_screen/widgets/grouped_notifications_list.dart';
import 'package:deadhour/screens/notifications_screen/widgets/notification_card.dart';
import 'package:deadhour/screens/notifications_screen/widgets/notifications_list.dart';
import 'package:deadhour/screens/notifications_screen/widgets/relevant_notifications_list.dart';
import 'package:deadhour/screens/notifications_screen/widgets/smart_header.dart';
import 'package:deadhour/screens/notifications_screen/widgets/stats_header.dart';
import 'package:deadhour/screens/offline_settings_screen/offline_settings_screen.dart';
import 'package:deadhour/screens/onboarding_screen/onboarding_page.dart';
import 'package:deadhour/screens/onboarding_screen/onboarding_screen.dart';
import 'package:deadhour/screens/payment_screen/payment_screen.dart';
import 'package:deadhour/screens/payment_screen/payment_state.dart';
import 'package:deadhour/screens/payment_screen/utils/card_number_input_formatter.dart';
import 'package:deadhour/screens/payment_screen/utils/expiry_date_input_formatter.dart';
import 'package:deadhour/screens/payment_screen/utils/payment_input_formatters.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_at_venue_form.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_bank_transfer_form.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_booking_summary_widget.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_card_form.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_forms_widget.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_method_selector_widget.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_mobile_money_form.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_submit_button_widget.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_success_dialog.dart';
import 'package:deadhour/screens/premium_role_screen/premium_role_screen.dart';
import 'package:deadhour/screens/profile_screen/models/user.dart';
import 'package:deadhour/screens/profile_screen/models/user_role.dart';
import 'package:deadhour/screens/profile_screen/profile_screen.dart';
import 'package:deadhour/screens/profile_screen/profile_screen_helpers.dart';
import 'package:deadhour/screens/profile_screen/providers/guest_mode_provider.dart';
import 'package:deadhour/screens/profile_screen/providers/role_toggle_provider.dart';
import 'package:deadhour/screens/profile_screen/providers/user_provider.dart';
import 'package:deadhour/screens/profile_screen/services/auth_exception.dart';
import 'package:deadhour/screens/profile_screen/services/auth_helpers.dart';
import 'package:deadhour/screens/profile_screen/services/auth_service.dart';
import 'package:deadhour/screens/profile_screen/services/cultural_calendar_service.dart';
import 'package:deadhour/screens/profile_screen/services/cultural_holiday.dart';
import 'package:deadhour/screens/profile_screen/services/guest_mode.dart';
import 'package:deadhour/screens/profile_screen/services/halal_status.dart';
import 'package:deadhour/screens/profile_screen/services/halal_status_extension.dart';
import 'package:deadhour/screens/profile_screen/services/holiday_type.dart';
import 'package:deadhour/screens/profile_screen/services/invalid_credentials_exception.dart';
import 'package:deadhour/screens/profile_screen/services/invalid_input_exception.dart';
import 'package:deadhour/screens/profile_screen/services/morocco_cultural_service.dart';
import 'package:deadhour/screens/profile_screen/services/network_effects_service.dart';
import 'package:deadhour/screens/profile_screen/services/network_exception.dart';
import 'package:deadhour/screens/profile_screen/services/next_prayer_info.dart';
import 'package:deadhour/screens/profile_screen/services/onboarding_service.dart';
import 'package:deadhour/screens/profile_screen/services/onboarding_step.dart';
import 'package:deadhour/screens/profile_screen/services/onboarding_step_extension.dart';
import 'package:deadhour/screens/profile_screen/services/ramadan_schedule.dart';
import 'package:deadhour/screens/profile_screen/services/role_data.dart';
import 'package:deadhour/screens/profile_screen/services/social_provider.dart';
import 'package:deadhour/screens/profile_screen/services/unauthenticated_exception.dart';
import 'package:deadhour/screens/profile_screen/services/user_data.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_business_impact_tab.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_cultural_insights_tab.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_dashboard_controls.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_metrics_overview.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_room_activity_tab.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_user_engagement_tab.dart';
import 'package:deadhour/screens/profile_screen/widgets/loading_state_wrapper.dart';
import 'package:deadhour/screens/profile_screen/widgets/loading_widgets.dart';
import 'package:deadhour/screens/profile_screen/widgets/mock_auth_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/monthly_network_effects_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/network_dashboard_actions_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/network_effects_kpis_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/optimization_opportunities_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/platform_health_metrics_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/prayer_schedule_card.dart';
import 'package:deadhour/screens/profile_screen/widgets/prayer_times_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_call_to_action.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_comparison_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_features_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_hero_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_management_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_pricing_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_testimonials_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_activity_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_app_features_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_auth_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_header_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_role_management_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_settings_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_support_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/pull_to_refresh_wrapper.dart';
import 'package:deadhour/screens/profile_screen/widgets/ramadan_insights_dialog.dart';
import 'package:deadhour/screens/profile_screen/widgets/ramadan_optimization_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_available_roles_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_current_roles_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_primary_selector.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_quick_switch.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_stacking_benefits.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_toggle.dart';
import 'package:deadhour/screens/profile_screen/widgets/shimmer_effect.dart';
import 'package:deadhour/screens/profile_screen/widgets/top_network_multipliers_widget.dart';
import 'package:deadhour/screens/register_screen/register_screen.dart';
import 'package:deadhour/screens/revenue_optimization_screen/revenue_optimization_screen.dart';
import 'package:deadhour/screens/role_marketplace_screen/role_marketplace_screen.dart';
import 'package:deadhour/screens/role_switching_screen/role_switcher.dart';
import 'package:deadhour/screens/role_switching_screen/role_switcher_bottom_sheet.dart';
import 'package:deadhour/screens/role_switching_screen/role_switcher_widget.dart';
import 'package:deadhour/screens/role_switching_screen/role_switching_screen.dart';
import 'package:deadhour/screens/room_chat_screen/room_chat_screen.dart';
import 'package:deadhour/screens/room_detail_screen/room_detail_screen.dart';
import 'package:deadhour/screens/rooms_screen/models/room.dart';
import 'package:deadhour/screens/rooms_screen/rooms_screen.dart';
import 'package:deadhour/screens/rooms_screen/services/buzz_level.dart';
import 'package:deadhour/screens/rooms_screen/services/chat_message_service.dart';
import 'package:deadhour/screens/rooms_screen/services/chat_real_time_service.dart';
import 'package:deadhour/screens/rooms_screen/services/checkin_mood.dart';
import 'package:deadhour/screens/rooms_screen/services/checkin_story.dart';
import 'package:deadhour/screens/rooms_screen/services/event_type.dart';
import 'package:deadhour/screens/rooms_screen/services/media_content.dart';
import 'package:deadhour/screens/rooms_screen/services/media_stats.dart';
import 'package:deadhour/screens/rooms_screen/services/media_thread.dart';
import 'package:deadhour/screens/rooms_screen/services/media_type.dart';
import 'package:deadhour/screens/rooms_screen/services/media_type_extension.dart';
import 'package:deadhour/screens/rooms_screen/services/media_upload_result.dart';
import 'package:deadhour/screens/rooms_screen/services/photo_category.dart';
import 'package:deadhour/screens/rooms_screen/services/rich_media_service.dart';
import 'package:deadhour/screens/rooms_screen/services/room_data.dart';
import 'package:deadhour/screens/rooms_screen/services/venue_activity.dart';
import 'package:deadhour/screens/rooms_screen/services/venue_event.dart';
import 'package:deadhour/screens/rooms_screen/services/venue_photo.dart';
import 'package:deadhour/screens/rooms_screen/services/venue_photo_summary.dart';
import 'package:deadhour/screens/rooms_screen/services/visual_content_service.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel_result.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel_service.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel_type.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel_type_extension.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_participant.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_quality.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_quality_extension.dart';
import 'package:deadhour/screens/rooms_screen/utils/room_chat_bottom_sheet_helpers.dart';
import 'package:deadhour/screens/rooms_screen/utils/room_chat_dialog_helpers.dart';
import 'package:deadhour/screens/rooms_screen/widgets/category_filter.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_action_buttons.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_message_bubble.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_message_filters.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_message_reactions.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_messages_list.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_typing_indicator.dart';
import 'package:deadhour/screens/rooms_screen/widgets/community_health_indicator.dart';
import 'package:deadhour/screens/rooms_screen/widgets/create_room_sheet.dart';
import 'package:deadhour/screens/rooms_screen/widgets/cultural_filters.dart';
import 'package:deadhour/screens/rooms_screen/widgets/empty_state_config.dart';
import 'package:deadhour/screens/rooms_screen/widgets/empty_state_type.dart';
import 'package:deadhour/screens/rooms_screen/widgets/empty_state_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/engaging_empty_state.dart';
import 'package:deadhour/screens/rooms_screen/widgets/enhanced_room_search.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/empty_media_state_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_card_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_details_content.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_details_dialog.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_grid_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_header_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_type_filter_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/message_input.dart';
import 'package:deadhour/screens/rooms_screen/widgets/popular_rooms_tab.dart';
import 'package:deadhour/screens/rooms_screen/widgets/premium_upgrade_helper.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rich_media_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/room_chat_app_bar.dart';
import 'package:deadhour/screens/rooms_screen/widgets/room_filter_logic.dart';
import 'package:deadhour/screens/rooms_screen/widgets/room_info_banner.dart';
import 'package:deadhour/screens/rooms_screen/widgets/room_interaction_helpers.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_scaffold.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/all_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/business_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/guide_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/my_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/popular_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/premium_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/shared/room_card.dart';
import 'package:deadhour/screens/rooms_screen/widgets/typing_indicator.dart';
import 'package:deadhour/screens/rooms_screen/widgets/voice_channel_widget.dart';
import 'package:deadhour/screens/settings_screen/settings_screen.dart';
import 'package:deadhour/screens/shared/dev_menu_components/app_bar_action.dart';
import 'package:deadhour/screens/shared/dev_menu_components/app_bar_actions_widget.dart';
import 'package:deadhour/screens/shared/dev_menu_components/app_bar_theme.dart';
import 'package:deadhour/screens/shared/dev_menu_components/city_selection_bottom_sheet.dart';
import 'package:deadhour/screens/shared/dev_menu_components/custom_bottom_navigation.dart';
import 'package:deadhour/screens/shared/dev_menu_components/dead_hour_app_bar.dart';
import 'package:deadhour/screens/shared/dev_menu_components/enhanced_app_bar.dart';
import 'package:deadhour/screens/shared/dev_menu_components/location_selector_widget.dart';
import 'package:deadhour/screens/shared/dev_menu_components/search_app_bar.dart';
import 'package:deadhour/screens/shared/dev_menu_components/search_bottom_sheet_widget.dart';
import 'package:deadhour/screens/shared/dev_menu_components/sliver_enhanced_app_bar.dart';
import 'package:deadhour/screens/shared/widgets/compact_offline_indicator.dart';
import 'package:deadhour/screens/shared/widgets/data_freshness_indicator.dart';
import 'package:deadhour/screens/shared/widgets/google_map_widget.dart';
import 'package:deadhour/screens/shared/widgets/offline_status_widget.dart';
import 'package:deadhour/screens/shared/widgets/optimized_image.dart';
import 'package:deadhour/screens/shared/widgets/optimized_list_view.dart';
import 'package:deadhour/screens/shared/widgets/performance_monitor_widget.dart';
import 'package:deadhour/screens/shared/widgets/prayer_time_indicator.dart';
import 'package:deadhour/screens/shared/widgets/ramadan_banner_widget.dart';
import 'package:deadhour/screens/shared/widgets/sync_floating_action_button.dart';
import 'package:deadhour/screens/social_discovery_screen/services/group_booking_service.dart';
import 'package:deadhour/screens/social_discovery_screen/services/social_validation_service.dart';
import 'package:deadhour/screens/social_discovery_screen/social_discovery_screen.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/benefit_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/category_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/connection_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/create_experience_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/experience_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/experiences_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_all_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_create_dialog.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_create_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_deals_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_details_dialog.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_empty_state.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_my_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_stats_header.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_tab_bar.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_deal_opportunity_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/my_connections_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/network_stat.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/social_action_helpers.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/social_filters_and_search.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/social_stats_header.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/social_tab_bar.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/upcoming_experience_card.dart';
import 'package:deadhour/screens/splash_screen/splash_screen.dart';
import 'package:deadhour/screens/tourism_screen/services/booking.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_availability.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_error_type.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_result.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_slot.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_status.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_update.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_update_type.dart';
import 'package:deadhour/screens/tourism_screen/services/cancellation_result.dart';
import 'package:deadhour/screens/tourism_screen/services/real_time_booking_service.dart';
import 'package:deadhour/screens/tourism_screen/services/support_contact.dart';
import 'package:deadhour/screens/tourism_screen/tourism_screen.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_action_button.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_availability_status.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_contact_information.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_date_selection.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_dialogs.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_header.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_participant_selection.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_price_summary.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_special_requests.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_time_slot_selection.dart';
import 'package:deadhour/screens/tourism_screen/widgets/cultural_dashboard.dart';
import 'package:deadhour/screens/tourism_screen/widgets/cultural_events.dart';
import 'package:deadhour/screens/tourism_screen/widgets/cultural_tab.dart';
import 'package:deadhour/screens/tourism_screen/widgets/cultural_tips.dart';
import 'package:deadhour/screens/tourism_screen/widgets/discover_tab.dart';
import 'package:deadhour/screens/tourism_screen/widgets/experiences_tab.dart';
import 'package:deadhour/screens/tourism_screen/widgets/local_experts_tab.dart';
import 'package:deadhour/screens/tourism_screen/widgets/map_view_widget.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/models/map_location.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/models/map_location_type.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/services/map_data_service.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_background.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_controls.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_filter_chips.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_grid_painter.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_location_details.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_markers.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_style_selector.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/streets_overlay_painter.dart';
import 'package:deadhour/screens/tourism_screen/widgets/quick_discovery_grid.dart';
import 'package:deadhour/screens/tourism_screen/widgets/real_time_booking_widget.dart';
import 'package:deadhour/screens/tourism_screen/widgets/social_discovery_button.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourism_welcome_banner.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_cultural_events.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_cultural_insights_card.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_featured_experiences.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_friendly_deals.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_local_expert_recommendations.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_location_selector.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_quick_actions.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_trending_deals.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_welcome_section.dart';
import 'package:deadhour/screens/tourism_screen/widgets/trending_experiences.dart';
import 'package:deadhour/screens/tourist_home_screen/tourist_home_screen.dart';
import 'package:deadhour/screens/venue_detail_screen/venue_detail_screen.dart';
import 'package:deadhour/screens/venues_screen/models/venue.dart';
import 'package:deadhour/screens/venues_screen/services/venue_data.dart';
import 'package:deadhour/screens/venues_screen/services/venue_discovery_service.dart';
import 'package:deadhour/screens/venues_screen/venues_screen.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/deal_validation_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/all_validations_dialog.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/compact_validation_view.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/empty_validations_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/rating_details_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_actions_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_card.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_header.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_type_chip.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_utils.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validations_list_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_amenities_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_basic_info_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_booking_flow_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_card.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_card_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_cultural_timing_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_deals_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_discovery_filters_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_discovery_map_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_header_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_info_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_list_view_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_nearby_view_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_reviews_widget.dart';
import 'package:deadhour/screens/web_companion/services/web_companion_service.dart';
import 'package:deadhour/screens/web_companion/web_companion_screen.dart';
import 'package:deadhour/screens/web_companion_screen/services/web_companion_service.dart';
import 'package:deadhour/utils/advanced_search_service.dart';
import 'package:deadhour/utils/app_border_radius.dart';
import 'package:deadhour/utils/app_error.dart';
import 'package:deadhour/utils/app_error_handler.dart';
import 'package:deadhour/utils/app_logger.dart';
import 'package:deadhour/utils/app_navigation.dart';
import 'package:deadhour/utils/app_performance_service.dart';
import 'package:deadhour/utils/app_routes.dart';
import 'package:deadhour/utils/app_routes_constants.dart';
import 'package:deadhour/utils/app_spacing.dart';
import 'package:deadhour/utils/cached_data.dart';
import 'package:deadhour/utils/constants.dart';
import 'package:deadhour/utils/deployment_optimization_service.dart';
import 'package:deadhour/utils/error_boundary.dart';
import 'package:deadhour/utils/error_handler.dart';
import 'package:deadhour/utils/error_type.dart';
import 'package:deadhour/utils/error_utils.dart';
import 'package:deadhour/utils/global_error_widget.dart';
import 'package:deadhour/utils/haptic_feedback_type.dart';
import 'package:deadhour/utils/lru_cache.dart';
import 'package:deadhour/utils/memoized_widget.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/utils/offline_data_info.dart';
import 'package:deadhour/utils/offline_data_status.dart';
import 'package:deadhour/utils/offline_service.dart';
import 'package:deadhour/utils/optimized_scroll_physics.dart';
import 'package:deadhour/utils/performance_monitor.dart';
import 'package:deadhour/utils/performance_optimization_service.dart';
import 'package:deadhour/utils/performance_utils.dart';
import 'package:deadhour/utils/retry_mechanism.dart';
import 'package:deadhour/utils/timeout_exception.dart';


import 'package:deadhour/app.dart';
import 'package:deadhour/main.dart';
import 'package:deadhour/screens/accessibility_settings_screen/accessibility_settings_screen.dart';
import 'package:deadhour/screens/accessibility_settings_screen/services/accessibility_service.dart';
import 'package:deadhour/screens/accessibility_settings_screen/services/accessible_bottom_navigation_bar.dart';
import 'package:deadhour/screens/accessibility_settings_screen/services/accessible_floating_action_button.dart';
import 'package:deadhour/screens/accessibility_settings_screen/services/accessible_tab_bar.dart';
import 'package:deadhour/screens/analytics_dashboard_screen/analytics_dashboard_screen.dart';
import 'package:deadhour/screens/booking_flow_screen/booking_confirmation_dialog.dart';
import 'package:deadhour/screens/booking_flow_screen/booking_flow_screen.dart';
import 'package:deadhour/screens/booking_flow_screen/booking_options_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/confirm_booking_button.dart';
import 'package:deadhour/screens/booking_flow_screen/cultural_timing_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/deal_summary_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/payment_method_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/social_booking_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/special_requests_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/time_selection_widget.dart';
import 'package:deadhour/screens/booking_flow_screen/total_and_sharing_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/business_dashboard_screen.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/analytics_data.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/analytics_events.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/analytics_properties.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/analytics_service.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/deal_suggestion.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/deal_suggestions_service.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/pricing_suggestion.dart';
import 'package:deadhour/screens/business_dashboard_screen/services/ramadan_business_service.dart';
import 'package:deadhour/screens/business_dashboard_screen/utils/business_action_helpers.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_competitor_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_customer_tab_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_demographic_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_feedback_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_kpi_card_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_metric_card_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_peak_hours_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_performance_tab_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_period_selector_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_recommendations_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_revenue_card_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_revenue_source_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_revenue_tab_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/analytics_weekly_chart_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/business_header.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/business_tab_bar.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/dead_hours_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_action_buttons.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_capacity_form.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_community_form.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_header.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_information_form.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_schedule_form.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_suggestions_widget.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deal_type_selection.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/deals_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/insights_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/overview_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/pricing_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/professional_action_card.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/professional_card.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/professional_gradient_card.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/professional_stats_card.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/promotions_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/settings_tab.dart';
import 'package:deadhour/screens/business_dashboard_screen/widgets/time_frame_selector.dart';
import 'package:deadhour/screens/community_health_dashboard_screen/community_health_dashboard_screen.dart';
import 'package:deadhour/screens/create_deal_screen/create_deal_screen.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/application_state.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/cultural_ambassador_application_screen.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/cultural_info_bottom_sheet.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/cultural_timing_widget.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_action_buttons.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_experience_step.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_expertise_step.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_personal_info_step.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_progress_widget.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_review_section.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_review_step.dart';
import 'package:deadhour/screens/cultural_ambassador_application_screen/widgets/application_success_dialog.dart';
import 'package:deadhour/screens/deals_screen/deals_screen.dart';
import 'package:deadhour/screens/deals_screen/filters/deal_filters_widget.dart';
import 'package:deadhour/screens/deals_screen/filters/deals_filters.dart';
import 'package:deadhour/screens/deals_screen/models/deal.dart';
import 'package:deadhour/screens/deals_screen/services/automatic_deal_service.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_calculation.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_service.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_status.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_summary.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_tier.dart';
import 'package:deadhour/screens/deals_screen/services/cashback_transaction.dart';
import 'package:deadhour/screens/deals_screen/services/community_status.dart';
import 'package:deadhour/screens/deals_screen/services/deal_data.dart';
import 'package:deadhour/screens/deals_screen/services/deal_interaction_service.dart';
import 'package:deadhour/screens/deals_screen/services/deal_photo.dart';
import 'package:deadhour/screens/deals_screen/services/deal_rating.dart';
import 'package:deadhour/screens/deals_screen/services/deal_validation.dart';
import 'package:deadhour/screens/deals_screen/services/deal_validation_service.dart';
import 'package:deadhour/screens/deals_screen/services/tier_requirement.dart';
import 'package:deadhour/screens/deals_screen/services/top_validator.dart';
import 'package:deadhour/screens/deals_screen/services/user_rating.dart';
import 'package:deadhour/screens/deals_screen/services/validation_summary.dart';
import 'package:deadhour/screens/deals_screen/services/validation_type.dart';
import 'package:deadhour/screens/deals_screen/services/withdrawal_method.dart';
import 'package:deadhour/screens/deals_screen/widgets/deal_card.dart';
import 'package:deadhour/screens/deals_screen/widgets/deals_header_widget.dart';
import 'package:deadhour/screens/deals_screen/widgets/deals_list_view.dart';
import 'package:deadhour/screens/deals_screen/widgets/deals_map_view.dart';
import 'package:deadhour/screens/deals_screen/widgets/optimized_list_view.dart';
import 'package:deadhour/screens/dev_menu_screen/dev_menu_prayer_times_widget.dart';
import 'package:deadhour/screens/dev_menu_screen/dev_menu_screen.dart';
import 'package:deadhour/screens/dev_menu_screen/dev_route.dart';
import 'package:deadhour/screens/group_booking_screen/group_booking_screen.dart';
import 'package:deadhour/screens/guide_role_screen/guide_role_screen.dart';
import 'package:deadhour/screens/home_screen/home_screen.dart';
import 'package:deadhour/screens/local_expert_screen/local_expert_screen.dart';
import 'package:deadhour/screens/login_screen/login_screen.dart';
import 'package:deadhour/screens/main_navigation_screen/main_navigation_screen.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_app_bars.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_controller.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_dialogs.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_item.dart';
import 'package:deadhour/screens/main_navigation_screen/navigation_items.dart';
import 'package:deadhour/screens/network_effects_dashboard_screen/network_effects_dashboard_screen.dart';
import 'package:deadhour/screens/notifications_screen/notification_badge_widget.dart';
import 'package:deadhour/screens/notifications_screen/notifications_bottom_sheet.dart';
import 'package:deadhour/screens/notifications_screen/notifications_screen.dart';
import 'package:deadhour/screens/notifications_screen/services/digest_item.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_action.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_digest.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_frequency.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_group.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_interaction.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_service.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_suggested_action.dart';
import 'package:deadhour/screens/notifications_screen/services/notification_summary.dart';
import 'package:deadhour/screens/notifications_screen/services/smart_notification.dart';
import 'package:deadhour/screens/notifications_screen/services/smart_notification_service.dart';
import 'package:deadhour/screens/notifications_screen/services/user_notification_preferences.dart';
import 'package:deadhour/screens/notifications_screen/utils/notification_helpers.dart';
import 'package:deadhour/screens/notifications_screen/widgets/empty_state.dart';
import 'package:deadhour/screens/notifications_screen/widgets/grouped_notifications_list.dart';
import 'package:deadhour/screens/notifications_screen/widgets/notification_card.dart';
import 'package:deadhour/screens/notifications_screen/widgets/notifications_list.dart';
import 'package:deadhour/screens/notifications_screen/widgets/relevant_notifications_list.dart';
import 'package:deadhour/screens/notifications_screen/widgets/smart_header.dart';
import 'package:deadhour/screens/notifications_screen/widgets/stats_header.dart';
import 'package:deadhour/screens/offline_settings_screen/offline_settings_screen.dart';
import 'package:deadhour/screens/onboarding_screen/onboarding_page.dart';
import 'package:deadhour/screens/onboarding_screen/onboarding_screen.dart';
import 'package:deadhour/screens/payment_screen/payment_screen.dart';
import 'package:deadhour/screens/payment_screen/payment_state.dart';
import 'package:deadhour/screens/payment_screen/utils/card_number_input_formatter.dart';
import 'package:deadhour/screens/payment_screen/utils/expiry_date_input_formatter.dart';
import 'package:deadhour/screens/payment_screen/utils/payment_input_formatters.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_at_venue_form.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_bank_transfer_form.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_booking_summary_widget.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_card_form.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_forms_widget.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_method_selector_widget.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_mobile_money_form.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_submit_button_widget.dart';
import 'package:deadhour/screens/payment_screen/widgets/payment_success_dialog.dart';
import 'package:deadhour/screens/premium_role_screen/premium_role_screen.dart';
import 'package:deadhour/screens/profile_screen/models/user.dart';
import 'package:deadhour/screens/profile_screen/models/user_role.dart';
import 'package:deadhour/screens/profile_screen/profile_screen.dart';
import 'package:deadhour/screens/profile_screen/profile_screen_helpers.dart';
import 'package:deadhour/screens/profile_screen/providers/guest_mode_provider.dart';
import 'package:deadhour/screens/profile_screen/providers/role_toggle_provider.dart';
import 'package:deadhour/screens/profile_screen/providers/user_provider.dart';
import 'package:deadhour/screens/profile_screen/services/auth_exception.dart';
import 'package:deadhour/screens/profile_screen/services/auth_helpers.dart';
import 'package:deadhour/screens/profile_screen/services/auth_service.dart';
import 'package:deadhour/screens/profile_screen/services/cultural_calendar_service.dart';
import 'package:deadhour/screens/profile_screen/services/cultural_holiday.dart';
import 'package:deadhour/screens/profile_screen/services/guest_mode.dart';
import 'package:deadhour/screens/profile_screen/services/halal_status.dart';
import 'package:deadhour/screens/profile_screen/services/halal_status_extension.dart';
import 'package:deadhour/screens/profile_screen/services/holiday_type.dart';
import 'package:deadhour/screens/profile_screen/services/invalid_credentials_exception.dart';
import 'package:deadhour/screens/profile_screen/services/invalid_input_exception.dart';
import 'package:deadhour/screens/profile_screen/services/morocco_cultural_service.dart';
import 'package:deadhour/screens/profile_screen/services/network_effects_service.dart';
import 'package:deadhour/screens/profile_screen/services/network_exception.dart';
import 'package:deadhour/screens/profile_screen/services/next_prayer_info.dart';
import 'package:deadhour/screens/profile_screen/services/onboarding_service.dart';
import 'package:deadhour/screens/profile_screen/services/onboarding_step.dart';
import 'package:deadhour/screens/profile_screen/services/onboarding_step_extension.dart';
import 'package:deadhour/screens/profile_screen/services/ramadan_schedule.dart';
import 'package:deadhour/screens/profile_screen/services/role_data.dart';
import 'package:deadhour/screens/profile_screen/services/social_provider.dart';
import 'package:deadhour/screens/profile_screen/services/unauthenticated_exception.dart';
import 'package:deadhour/screens/profile_screen/services/user_data.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_business_impact_tab.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_cultural_insights_tab.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_dashboard_controls.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_metrics_overview.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_room_activity_tab.dart';
import 'package:deadhour/screens/profile_screen/widgets/health_user_engagement_tab.dart';
import 'package:deadhour/screens/profile_screen/widgets/loading_state_wrapper.dart';
import 'package:deadhour/screens/profile_screen/widgets/loading_widgets.dart';
import 'package:deadhour/screens/profile_screen/widgets/mock_auth_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/monthly_network_effects_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/network_dashboard_actions_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/network_effects_kpis_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/optimization_opportunities_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/platform_health_metrics_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/prayer_schedule_card.dart';
import 'package:deadhour/screens/profile_screen/widgets/prayer_times_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_call_to_action.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_comparison_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_features_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_hero_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_management_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_pricing_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/premium_testimonials_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_activity_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_app_features_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_auth_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_header_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_role_management_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_settings_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/profile_support_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/pull_to_refresh_wrapper.dart';
import 'package:deadhour/screens/profile_screen/widgets/ramadan_insights_dialog.dart';
import 'package:deadhour/screens/profile_screen/widgets/ramadan_optimization_widget.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_available_roles_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_current_roles_section.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_primary_selector.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_quick_switch.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_stacking_benefits.dart';
import 'package:deadhour/screens/profile_screen/widgets/role_toggle.dart';
import 'package:deadhour/screens/profile_screen/widgets/shimmer_effect.dart';
import 'package:deadhour/screens/profile_screen/widgets/top_network_multipliers_widget.dart';
import 'package:deadhour/screens/register_screen/register_screen.dart';
import 'package:deadhour/screens/revenue_optimization_screen/revenue_optimization_screen.dart';
import 'package:deadhour/screens/role_marketplace_screen/role_marketplace_screen.dart';
import 'package:deadhour/screens/role_switching_screen/role_switcher.dart';
import 'package:deadhour/screens/role_switching_screen/role_switcher_bottom_sheet.dart';
import 'package:deadhour/screens/role_switching_screen/role_switcher_widget.dart';
import 'package:deadhour/screens/role_switching_screen/role_switching_screen.dart';
import 'package:deadhour/screens/room_chat_screen/room_chat_screen.dart';
import 'package:deadhour/screens/room_detail_screen/room_detail_screen.dart';
import 'package:deadhour/screens/rooms_screen/models/room.dart';
import 'package:deadhour/screens/rooms_screen/rooms_screen.dart';
import 'package:deadhour/screens/rooms_screen/services/buzz_level.dart';
import 'package:deadhour/screens/rooms_screen/services/chat_message_service.dart';
import 'package:deadhour/screens/rooms_screen/services/chat_real_time_service.dart';
import 'package:deadhour/screens/rooms_screen/services/checkin_mood.dart';
import 'package:deadhour/screens/rooms_screen/services/checkin_story.dart';
import 'package:deadhour/screens/rooms_screen/services/event_type.dart';
import 'package:deadhour/screens/rooms_screen/services/media_content.dart';
import 'package:deadhour/screens/rooms_screen/services/media_stats.dart';
import 'package:deadhour/screens/rooms_screen/services/media_thread.dart';
import 'package:deadhour/screens/rooms_screen/services/media_type.dart';
import 'package:deadhour/screens/rooms_screen/services/media_type_extension.dart';
import 'package:deadhour/screens/rooms_screen/services/media_upload_result.dart';
import 'package:deadhour/screens/rooms_screen/services/photo_category.dart';
import 'package:deadhour/screens/rooms_screen/services/rich_media_service.dart';
import 'package:deadhour/screens/rooms_screen/services/room_data.dart';
import 'package:deadhour/screens/rooms_screen/services/venue_activity.dart';
import 'package:deadhour/screens/rooms_screen/services/venue_event.dart';
import 'package:deadhour/screens/rooms_screen/services/venue_photo.dart';
import 'package:deadhour/screens/rooms_screen/services/venue_photo_summary.dart';
import 'package:deadhour/screens/rooms_screen/services/visual_content_service.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel_result.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel_service.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel_type.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_channel_type_extension.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_participant.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_quality.dart';
import 'package:deadhour/screens/rooms_screen/services/voice_quality_extension.dart';
import 'package:deadhour/screens/rooms_screen/utils/room_chat_bottom_sheet_helpers.dart';
import 'package:deadhour/screens/rooms_screen/utils/room_chat_dialog_helpers.dart';
import 'package:deadhour/screens/rooms_screen/widgets/category_filter.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_action_buttons.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_message_bubble.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_message_filters.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_message_reactions.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_messages_list.dart';
import 'package:deadhour/screens/rooms_screen/widgets/chat_typing_indicator.dart';
import 'package:deadhour/screens/rooms_screen/widgets/community_health_indicator.dart';
import 'package:deadhour/screens/rooms_screen/widgets/create_room_sheet.dart';
import 'package:deadhour/screens/rooms_screen/widgets/cultural_filters.dart';
import 'package:deadhour/screens/rooms_screen/widgets/empty_state_config.dart';
import 'package:deadhour/screens/rooms_screen/widgets/empty_state_type.dart';
import 'package:deadhour/screens/rooms_screen/widgets/empty_state_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/engaging_empty_state.dart';
import 'package:deadhour/screens/rooms_screen/widgets/enhanced_room_search.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/empty_media_state_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_card_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_details_content.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_details_dialog.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_grid_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_header_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/media/media_type_filter_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/message_input.dart';
import 'package:deadhour/screens/rooms_screen/widgets/popular_rooms_tab.dart';
import 'package:deadhour/screens/rooms_screen/widgets/premium_upgrade_helper.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rich_media_widget.dart';
import 'package:deadhour/screens/rooms_screen/widgets/room_chat_app_bar.dart';
import 'package:deadhour/screens/rooms_screen/widgets/room_filter_logic.dart';
import 'package:deadhour/screens/rooms_screen/widgets/room_info_banner.dart';
import 'package:deadhour/screens/rooms_screen/widgets/room_interaction_helpers.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_scaffold.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/all_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/business_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/guide_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/my_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/popular_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/rooms_tabs/premium_rooms_tab_view.dart';
import 'package:deadhour/screens/rooms_screen/widgets/shared/room_card.dart';
import 'package:deadhour/screens/rooms_screen/widgets/typing_indicator.dart';
import 'package:deadhour/screens/rooms_screen/widgets/voice_channel_widget.dart';
import 'package:deadhour/screens/settings_screen/settings_screen.dart';
import 'package:deadhour/screens/shared/dev_menu_components/app_bar_action.dart';
import 'package:deadhour/screens/shared/dev_menu_components/app_bar_actions_widget.dart';
import 'package:deadhour/screens/shared/dev_menu_components/app_bar_theme.dart';
import 'package:deadhour/screens/shared/dev_menu_components/city_selection_bottom_sheet.dart';
import 'package:deadhour/screens/shared/dev_menu_components/custom_bottom_navigation.dart';
import 'package:deadhour/screens/shared/dev_menu_components/dead_hour_app_bar.dart';
import 'package:deadhour/screens/shared/dev_menu_components/enhanced_app_bar.dart';
import 'package:deadhour/screens/shared/dev_menu_components/location_selector_widget.dart';
import 'package:deadhour/screens/shared/dev_menu_components/search_app_bar.dart';
import 'package:deadhour/screens/shared/dev_menu_components/search_bottom_sheet_widget.dart';
import 'package:deadhour/screens/shared/dev_menu_components/sliver_enhanced_app_bar.dart';
import 'package:deadhour/screens/shared/widgets/compact_offline_indicator.dart';
import 'package:deadhour/screens/shared/widgets/data_freshness_indicator.dart';
import 'package:deadhour/screens/shared/widgets/google_map_widget.dart';
import 'package:deadhour/screens/shared/widgets/offline_status_widget.dart';
import 'package:deadhour/screens/shared/widgets/optimized_image.dart';
import 'package:deadhour/screens/shared/widgets/optimized_list_view.dart';
import 'package:deadhour/screens/shared/widgets/performance_monitor_widget.dart';
import 'package:deadhour/screens/shared/widgets/prayer_time_indicator.dart';
import 'package:deadhour/screens/shared/widgets/ramadan_banner_widget.dart';
import 'package:deadhour/screens/shared/widgets/sync_floating_action_button.dart';
import 'package:deadhour/screens/social_discovery_screen/services/group_booking_service.dart';
import 'package:deadhour/screens/social_discovery_screen/services/social_validation_service.dart';
import 'package:deadhour/screens/social_discovery_screen/social_discovery_screen.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/benefit_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/category_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/connection_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/create_experience_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/experience_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/experiences_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_all_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_create_dialog.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_create_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_deals_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_details_dialog.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_empty_state.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_my_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_stats_header.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_booking_tab_bar.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/group_deal_opportunity_card.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/my_connections_tab.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/network_stat.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/social_action_helpers.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/social_filters_and_search.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/social_stats_header.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/social_tab_bar.dart';
import 'package:deadhour/screens/social_discovery_screen/widgets/upcoming_experience_card.dart';
import 'package:deadhour/screens/splash_screen/splash_screen.dart';
import 'package:deadhour/screens/tourism_screen/services/booking.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_availability.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_error_type.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_result.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_slot.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_status.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_update.dart';
import 'package:deadhour/screens/tourism_screen/services/booking_update_type.dart';
import 'package:deadhour/screens/tourism_screen/services/cancellation_result.dart';
import 'package:deadhour/screens/tourism_screen/services/real_time_booking_service.dart';
import 'package:deadhour/screens/tourism_screen/services/support_contact.dart';
import 'package:deadhour/screens/tourism_screen/tourism_screen.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_action_button.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_availability_status.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_contact_information.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_date_selection.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_dialogs.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_header.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_participant_selection.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_price_summary.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_special_requests.dart';
import 'package:deadhour/screens/tourism_screen/widgets/booking/booking_time_slot_selection.dart';
import 'package:deadhour/screens/tourism_screen/widgets/cultural_dashboard.dart';
import 'package:deadhour/screens/tourism_screen/widgets/cultural_events.dart';
import 'package:deadhour/screens/tourism_screen/widgets/cultural_tab.dart';
import 'package:deadhour/screens/tourism_screen/widgets/cultural_tips.dart';
import 'package:deadhour/screens/tourism_screen/widgets/discover_tab.dart';
import 'package:deadhour/screens/tourism_screen/widgets/experiences_tab.dart';
import 'package:deadhour/screens/tourism_screen/widgets/local_experts_tab.dart';
import 'package:deadhour/screens/tourism_screen/widgets/map_view_widget.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/models/map_location.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/models/map_location_type.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/services/map_data_service.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_background.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_controls.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_filter_chips.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_grid_painter.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_location_details.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_markers.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/map_style_selector.dart';
import 'package:deadhour/screens/tourism_screen/widgets/maps/widgets/streets_overlay_painter.dart';
import 'package:deadhour/screens/tourism_screen/widgets/quick_discovery_grid.dart';
import 'package:deadhour/screens/tourism_screen/widgets/real_time_booking_widget.dart';
import 'package:deadhour/screens/tourism_screen/widgets/social_discovery_button.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourism_welcome_banner.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_cultural_events.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_cultural_insights_card.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_featured_experiences.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_friendly_deals.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_local_expert_recommendations.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_location_selector.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_quick_actions.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_trending_deals.dart';
import 'package:deadhour/screens/tourism_screen/widgets/tourist_welcome_section.dart';
import 'package:deadhour/screens/tourism_screen/widgets/trending_experiences.dart';
import 'package:deadhour/screens/tourist_home_screen/tourist_home_screen.dart';
import 'package:deadhour/screens/venue_detail_screen/venue_detail_screen.dart';
import 'package:deadhour/screens/venues_screen/models/venue.dart';
import 'package:deadhour/screens/venues_screen/services/venue_data.dart';
import 'package:deadhour/screens/venues_screen/services/venue_discovery_service.dart';
import 'package:deadhour/screens/venues_screen/venues_screen.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/deal_validation_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/all_validations_dialog.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/compact_validation_view.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/empty_validations_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/rating_details_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_actions_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_card.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_header.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_type_chip.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validation_utils.dart';
import 'package:deadhour/screens/venues_screen/widgets/deals/validation/validations_list_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_amenities_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_basic_info_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_booking_flow_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_card.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_card_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_cultural_timing_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_deals_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_discovery_filters_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_discovery_map_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_header_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_info_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_list_view_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_nearby_view_widget.dart';
import 'package:deadhour/screens/venues_screen/widgets/venue_reviews_widget.dart';
import 'package:deadhour/screens/web_companion/services/web_companion_service.dart';
import 'package:deadhour/screens/web_companion/web_companion_screen.dart';
import 'package:deadhour/screens/web_companion_screen/services/web_companion_service.dart';
import 'package:deadhour/utils/advanced_search_service.dart';
import 'package:deadhour/utils/app_border_radius.dart';
import 'package:deadhour/utils/app_error.dart';
import 'package:deadhour/utils/app_error_handler.dart';
import 'package:deadhour/utils/app_logger.dart';
import 'package:deadhour/utils/app_navigation.dart';
import 'package:deadhour/utils/app_performance_service.dart';
import 'package:deadhour/utils/app_routes.dart';
import 'package:deadhour/utils/app_routes_constants.dart';
import 'package:deadhour/utils/app_spacing.dart';
import 'package:deadhour/utils/cached_data.dart';
import 'package:deadhour/utils/constants.dart';
import 'package:deadhour/utils/deployment_optimization_service.dart';
import 'package:deadhour/utils/error_boundary.dart';
import 'package:deadhour/utils/error_handler.dart';
import 'package:deadhour/utils/error_type.dart';
import 'package:deadhour/utils/error_utils.dart';
import 'package:deadhour/utils/global_error_widget.dart';
import 'package:deadhour/utils/haptic_feedback_type.dart';
import 'package:deadhour/utils/lru_cache.dart';
import 'package:deadhour/utils/memoized_widget.dart';
import 'package:deadhour/utils/mock_data.dart';
import 'package:deadhour/utils/offline_data_info.dart';
import 'package:deadhour/utils/offline_data_status.dart';
import 'package:deadhour/utils/offline_service.dart';
import 'package:deadhour/utils/optimized_scroll_physics.dart';
import 'package:deadhour/utils/performance_monitor.dart';
import 'package:deadhour/utils/performance_optimization_service.dart';
import 'package:deadhour/utils/performance_utils.dart';
import 'package:deadhour/utils/retry_mechanism.dart';
import 'package:deadhour/utils/timeout_exception.dart';

/// Screen for managing browser extension and web companion features
class WebCompanionScreen extends StatefulWidget {
  const WebCompanionScreen({super.key});

  @override
  State<WebCompanionScreen> createState() => _WebCompanionScreenState();
}

class _WebCompanionScreenState extends State<WebCompanionScreen> {
  final WebCompanionService _webService = WebCompanionService();
  String _selectedBrowser = 'chrome';

  @override
  void initState() {
    super.initState();
    _webService.initializeWebCompanion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browser Extension'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeaderSection(),
            const SizedBox(height: 24),

            // Features section
            _buildFeaturesSection(),
            const SizedBox(height: 24),

            // Installation section
            _buildInstallationSection(),
            const SizedBox(height: 24),

            // Bookmarklet section
            _buildBookmarkletSection(),
            const SizedBox(height: 24),

            // Supported websites
            _buildSupportedWebsitesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.moroccoGreen,
            AppTheme.moroccoGreen.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.extension,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DeadHour Browser Extension',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Find Morocco deals while browsing',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Get notified about better DeadHour deals when browsing international booking sites. Like Honey for coupons, but for Morocco\'s dead hour deals with cashback.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {
        'icon': Icons.notifications_active,
        'title': 'Smart Deal Notifications',
        'description': 'Get alerts when browsing travel sites about better Morocco deals',
        'color': Colors.blue,
      },
      {
        'icon': Icons.auto_mode,
        'title': 'Auto-Deal Detection',
        'description': 'Automatically finds DeadHour alternatives while you browse',
        'color': AppTheme.moroccoGreen,
      },
      {
        'icon': Icons.monetization_on,
        'title': 'Cashback Alerts',
        'description': 'Shows potential cashback earnings on Morocco bookings',
        'color': Colors.orange,
      },
      {
        'icon': Icons.compare_arrows,
        'title': 'Price Comparison',
        'description': 'Compare international prices with local Morocco deals',
        'color': Colors.purple,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Extension Features',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...features.map((feature) => _buildFeatureCard(feature)),
      ],
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: feature['color'].withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature['icon'],
              color: feature['color'],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstallationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Install Browser Extension',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Browser selection
        Row(
          children: [
            _buildBrowserButton('chrome', 'Chrome', Icons.web),
            const SizedBox(width: 12),
            _buildBrowserButton('firefox', 'Firefox', Icons.web_asset),
          ],
        ),
        const SizedBox(height: 16),

        // Installation instructions
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _selectedBrowser == 'chrome' ? Icons.web : Icons.web_asset,
                    color: AppTheme.moroccoGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Installation Instructions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _webService.getInstallationInstructions()[_selectedBrowser] ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Download button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _downloadExtension,
            icon: const Icon(Icons.download),
            label: Text('Download ${_selectedBrowser == 'chrome' ? 'Chrome' : 'Firefox'} Extension'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppTheme.moroccoGreen,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrowserButton(String browser, String label, IconData icon) {
    final isSelected = _selectedBrowser == browser;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedBrowser = browser;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.moroccoGreen.withValues(alpha: 0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.moroccoGreen : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? AppTheme.moroccoGreen : Colors.grey,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppTheme.moroccoGreen : AppTheme.primaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookmarkletSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Setup: Bookmarklet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Can\'t install extensions? Use our bookmarklet for instant access on any browser.',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryText,
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.bookmark_add,
                    color: Colors.amber,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Bookmarklet Instructions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _webService.getInstallationInstructions()['bookmarklet'] ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Copy bookmarklet button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _copyBookmarklet,
            icon: const Icon(Icons.copy),
            label: const Text('Copy Bookmarklet Code'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.amber),
              foregroundColor: Colors.amber.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportedWebsitesSection() {
    final websites = [
      {'name': 'Booking.com', 'icon': '🏨', 'category': 'Hotels'},
      {'name': 'Airbnb', 'icon': '🏠', 'category': 'Accommodations'},
      {'name': 'TripAdvisor', 'icon': '✈️', 'category': 'Travel'},
      {'name': 'Expedia', 'icon': '🌍', 'category': 'Travel'},
      {'name': 'Agoda', 'icon': '🏖️', 'category': 'Hotels'},
      {'name': 'Hotels.com', 'icon': '🛏️', 'category': 'Hotels'},
      {'name': 'VisitMorocco.com', 'icon': '🇲🇦', 'category': 'Local'},
      {'name': 'Restaurant.ma', 'icon': '🍽️', 'category': 'Dining'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Supported Websites',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'The extension works on these popular booking and travel websites.',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryText,
          ),
        ),
        const SizedBox(height: 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3,
          ),
          itemCount: websites.length,
          itemBuilder: (context, index) {
            final website = websites[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Text(
                    website['icon']!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          website['name']!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          website['category']!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _downloadExtension() {
    // In a real app, this would trigger a download
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Extension Download'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('The ${_selectedBrowser == 'chrome' ? 'Chrome' : 'Firefox'} extension is being prepared for download.'),
            const SizedBox(height: 16),
            const Text(
              'Note: This is a demo. In the full version, you would download extension files and follow the installation instructions.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryText,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _copyBookmarklet() {
    final bookmarklet = _webService.generateBookmarklet();
    Clipboard.setData(ClipboardData(text: bookmarklet));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Bookmarklet code copied to clipboard!'),
          ],
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }
}