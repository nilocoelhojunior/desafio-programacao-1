$(document).on('turbolinks:load', function () {
  $('#customFile').change(function () {
    //get the file name
    var fileName = $(this).val();
    //replace the "Choose a file" label
    console.log(fileName)
    $('.custom-file-label').html(fileName.split(/(\\|\/)/g).pop());
  })
})