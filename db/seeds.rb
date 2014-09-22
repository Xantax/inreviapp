# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

temporals = Temporal.create([{ name: 'hours' }, { name: 'days' }, { name: 'weeks' }, { name: 'months' }, { name: 'years' }])
per_temporals = PerTemporal.create([{ name: 'an hour' }, { name: 'a day' }, { name: 'a week' }, { name: 'a month' }, { name: 'a year' }])