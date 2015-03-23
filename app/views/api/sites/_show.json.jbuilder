json.id site.id
json.name site.name
json.title site.title
json.host site.host
json.domain site.domain
json.subdomain site.subdomain
json.description site.description
json.languages site.menus.pluck(:language_id)
