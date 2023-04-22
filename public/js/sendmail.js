function addRecipient() {
  var form = document.querySelector(".form");
  var div = document.createElement("div");
  div.innerHTML =
    '<p><label>To: <input type="email" name="to[]" class="email" required></label></p>' +
    '<p><label>Cc: <input type="email" name="cc[]"></label></p>' +
    '<p><label>Bcc: <input type="email" name="bcc[]"></label></p>';
  form.insertBefore(div, form.lastElementChild);
}

btnSubmit=()=>{
    data={
        type:"send_mail",
        receiver:$("#email").val(),
        subject:$("#subject").val(),
        content:$("#content").val()
    }
    fetch("../controllers/MailBoxController.php", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(data),
      })
        .then((response) => response.json())
        .then((datas) => console.log(datas))
        .catch((error) => console.log("Error:", error));
}