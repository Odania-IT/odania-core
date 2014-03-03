# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Odania::Language.find_or_create_by(name: 'German', iso_639_1: 'de')
Odania::Language.find_or_create_by(name: 'English', iso_639_1: 'en')
