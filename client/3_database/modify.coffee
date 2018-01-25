###############################################################################
#
# Markus 16/12/2017
#
###############################################################################

###############################################################################
_verbose = false


###############################################################################
@set_field = (collection, document, field, value, callback=null) ->
	if typeof collection != "string"
		collection = collection._name

	if typeof document != "string"
		document = document._id

	trace = stack_trace()
	if not callback
		callback = (err, res) ->
			if err
				err_msg = "Server error modifying " + field + ": "
				err_msg += err
				err_msg += "A stack trace was written to the console."
				sAlert.error(err_msg)

				console.log "Client method set_field caused server error: "
				console.log err
				console.log "Client stack trace: "
				console.log trace

			if res & _verbose
				silent = false
				profile = get_profile()
				if profile
					silent = profile.silent
				if not silent
					sAlert.success("Updated: " + field + " on server")

	Meteor.call "set_field", collection, document, field, value, callback