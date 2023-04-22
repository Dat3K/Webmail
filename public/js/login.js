// main
$("#login_btn").click((e) => {
  e.preventDefault();
  loginBtnClick();
});

$("#register_btn").click((e) => {
  e.preventDefault();
  regBtnClick();
});




// hàm nhấn login
loginBtnClick = () => {
  data = {
    type: $("#login_btn").val(),
    email: $("#login_email").val(),
    password: $("#login_password").val(),
  };
  fetch("../../app/controllers/UserController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data["status"]) {
        alert("Logged in successfully");
        window.location.href = "webdisplay.html";
      } else {
        $("#error").html(`<div class="alert alert-danger" role="alert">
                          ${data["msg"]}
                        </div>`);
      }
      console.log(data);
    })
    .catch((error) => console.error(error));
};

// hàm nhấn register
regBtnClick = () => {
  data = {
    type: $("#register_btn").val(),
    ussername:$("#register_name").val(),
    email: $("#register_email").val(),
    password: $("#register_password").val(),
    re_password: $("#register_re_password").val(),
  };
  fetch("../../app/controllers/UserController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data["status"]==true) {
        alert("Successful registration");
        window.location.href = "sign_in.html";
      } else {
        $("#error").html(`<div class="alert alert-danger" role="alert">
                          ${data["msg"]}
                        </div>`);
      }
      console.log(data);
    })
    .catch((error) => console.error(error));
};



