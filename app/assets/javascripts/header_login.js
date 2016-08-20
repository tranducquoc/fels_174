$('#show-form-login').on('click',function(){
  if($('#form-login').css('display') === 'block'){
    $('#form-login').slideUp();
  }
  else{
    $('#form-login').slideDown();
  }
});
$('#btnLogin').on('click',function(){
  var email = $('#email').val();
  var password = $('#password').val();
  $.ajax({
    method: 'post',
    url: '/login.json',
    dataType: 'json',
    data: {email: email,password: password},
    success: function(response){
      var result =  response.result;
      if('success' === result){
        var user = response.user;
        if(user.is_admin){
          window.location.href = '/admin/users'
        }
        else{
          window.location.href = '/users/'+user.id;
        }
      }
      else {
        $('#message-err').html(''+response.message);
      }
    },
    error: function(error_message){
      alert('error: '+ error_message);
    }
  });
});

