json.id site.id
json.name site.name
json.title site.title
json.host site.host
json.domain site.domain
json.subdomain site.subdomain
json.is_active site.is_active
json.description site.description
json.user_signup_allowed site.user_signup_allowed
json.default_language_id site.default_language_id
json.redirect_to_id site.redirect_to_id
json.social site.social

json.languages site.menus.pluck(:language_id)
