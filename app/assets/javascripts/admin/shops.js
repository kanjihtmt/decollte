$(function() {
  var $el = document.getElementById("sortable_list")

  $.ajaxSetup({
    headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
  });

  if ($el != null) {
    Sortable.create($el, {
      delay: 200,
      onUpdate: function(e) {
        var id = $(e.target).find('tr').data('id');
        $.ajax({
          url: '/admin/sortable/brand/' + $('#brand_id').val() + '/shops/' + id,
          type: 'patch',
          data: {
            from: e.oldIndex, to: e.newIndex
          }
        });
      }
    });
  }
});
