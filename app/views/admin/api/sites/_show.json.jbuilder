json.id site.id
json.name site.name
json.title site.title
json.host site.host
json.domain site.domain
json.subdomain site.subdomain
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
json.imprint_id site.imprint_id
json.terms_and_conditions_id site.terms_and_conditions_id
json.default_widget_id site.default_widget_id
json.social site.social
json.meta site.meta
json.additional_parameters site.additional_parameters

json.menus site.menus, partial: 'admin/api/menus/show', as: :menu
json.languages site.menus.pluck(:language_id)
