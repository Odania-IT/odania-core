json.id site.id
json.name site.name
json.host site.host
json.is_active site.is_active
json.is_default site.is_default
json.tracking_code site.tracking_code
json.description site.description
json.template site.template
json.user_signup_allowed site.user_signup_allowed
json.default_language_id site.default_language_id
json.redirect_to_id site.redirect_to_id
json.default_from_email site.default_from_email
json.notify_email_address site.notify_email_address
json.imprint site.imprint
json.terms_and_conditions site.terms_and_conditions
json.default_widget_id site.default_widget_id
json.social site.social

json.menus site.menus, partial: 'admin/api/menus/show', as: :menu
json.languages site.menus.pluck(:language_id)
