$ ->
  $('a.reply_link').on 'click', (e) ->
    $link = $(this)
    $reply = $('#reply_template').clone()
    $reply.appendTo($(this).parent('section').parent())

    id = $link.data('commentable-id')
    $reply.find('#commentable_id').val(id)

    type = $link.data('commentable-type')
    $reply.find('#commentable_type').val(type)

    $reply.show()
    $(this).hide()
    false

