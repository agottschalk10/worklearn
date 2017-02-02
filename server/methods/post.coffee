################################################################
#
# Markus 1/23/2017
#
################################################################

################################################################
Meteor.methods
	add_post: (template) ->
		user = Meteor.user()

		if not user
			throw new Meteor.Error('Not permitted.')

		if !Roles.userIsInRole(user._id, 'editor')
			throw new Meteor.Error('Not permitted.')

		post =
			template: template
			owner_id: Meteor.userId()
			pub_year: 0

		Posts.insert post

	set_post_field: (collection, item_id, field, data, type)->
		modify_field('Posts', item_id, field, data)
