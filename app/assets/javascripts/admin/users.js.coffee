class UrbanHelpline.Admin.Users

  @init: ->
    if $(".change_password").length > 0
      $(".password_fields").hide();

    $(".change_password").click ->
      $(".password_fields").toggle();