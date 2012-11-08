
Accounts.emailTemplates.siteName = "Whizmo"
Accounts.emailTemplates.from = "Whizmo Admin <whizmo@whizmo.herokuapp.com>"
Accounts.emailTemplates.enrollAccount.subject = (user) ->
  "Welcome to Whizmo, #{user.profile.name}"
Accounts.emailTemplates.enrollAccount.text = (user, url) ->
  "You have been selected to participate in building a better future!"
  " To activate your account, simply click the link below:\n\n#{url}"

