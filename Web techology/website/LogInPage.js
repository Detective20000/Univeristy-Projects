var user = ["Mohanad", "Suhaib"];
var userspassword = ["1625331", "1531409"];

$("#submit").click(function() {

  var Username = document.getElementById('Username').value;
  var Password = document.getElementById('Password').value;

  console.log(Username);
  if (Username == user[0]) {
    console.log(Password);
    if (Password == userspassword[0]) {
      location.href = 'AddMovie.html';
    } else {
      alert( "Wrong username or password" );
      document.getElementById('Password').value = '';
    }

  } else if (Username == user[1]) {
    if (Password == userspassword[1]) {
      location.href = 'AddMovie.html';

    } else {
      alert( "Wrong username or password" );
      document.getElementById('Password').value = '';
    }

  } else {
    alert( "Wrong username" );
    document.getElementById('Username').value = '';
    document.getElementById('Password').value = '';
  }
});
