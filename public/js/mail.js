$(document).ready(() => {
  $("#list_mail").empty();
  alert("okde");
  // getInbox();
});

//  Lấy hộp thư đến
getInbox = () => {
  fetch("../../app/controllers/MailBoxController.php")
    .then((response) => response.json())
    .then((datas) => {
      $("#list_mail").html(getMailHtml(datas.data, datas.user_id));
      $("#user_id").data("id", datas.user_id);
    })
    .catch((error) => console.log("Error:", error));
};

// lấy tất cả thư
getAllMail = () => {
  fetch("../../app/controllers/MailboxController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ type: "all_mail" }),
  })
    .then((response) => response.json())
    .then((datas) => $("#list_mail").html(getMailHtml(datas, datas.user_id)))
    .catch((error) => console.log("Error:", error));
};

// Lấy thư đánh dấu sao
getStarredMail = () => {
  fetch("../../app/controllers/MailboxController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ type: "starred_mail" }),
  })
    .then((response) => response.json())
    .then((datas) => $("#list_mail").html(getMailHtml(datas)))
    .catch((error) => console.log("Error:", error));
};

// Lấy thư đã gửi
getSentMail = () => {
  fetch("../../app/controllers/MailBoxController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ type: "sent_mail" }),
  })
    .then((response) => response.json())
    .then((datas) => $("#list_mail").html(getMailHtml(datas, "send _type")))
    .catch((error) => console.log("Error:", error));
};

// lấy thư rác
getTrashMail = () => {
  fetch("../../app/controllers/MailBoxController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ type: "trash_mail" }),
  })
    .then((response) => response.json())
    .then((datas) => $("#list_mail").html(getMailHtml(datas)))
    .catch((error) => console.log("Error:", error));
};

//  Lấy mail đã xoá
getDeletedMail = () => {
  fetch("../../app/controllers/MailBoxController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ type: "deleted_mail" }),
  })
    .then((response) => response.json())
    .then((datas) => $("#list_mail").html(getMailHtml(datas)))
    .catch((error) => console.log("Error:", error));
};

// Lấy mail đã lưu trữ
getArchivedMail = () => {
  fetch("../../app/controllers/MailBoxController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ type: "archived_mail" }),
  })
    .then((response) => response.json())
    .then((datas) => $("#list_mail").html(getMailHtml(datas)))
    .catch((error) => console.log("Error:", error));
};

getUnreadMail = () => {
  fetch("../../app/controllers/MailBoxController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ type: "unread_mail" }),
  })
    .then((response) => response.json())
    .then((datas) => $("#list_mail").html(getMailHtml(datas)))
    .catch((error) => console.log("Error:", error));
};

logOut = () => {
  fetch("../../app/controllers/MailBoxController.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ type: "log_out" }),
  })
    .then((response) => response.json())
    .then((datas) => {
      alert(datas.msg);
    })
    .catch((error) => console.log("Error:", error));
};

// hàm trả về html messages đã format
getMailHtml = (datas, user_id) => {
  let htmls = datas.map((data) => {
    if (data.is_starred == 0) {
      // Check starred mail
      starHtml = `<i class="fa fa-star" style="color: black;"></i>`;
    } else {
      starHtml = `<i class="fa fa-star" style="color: yellow;"></i>`;
    }

    if (data.is_read == 1) {
      //  Check read mail
      readStyleHtml = `style="background-color: #f2f6fc;font-weight: normal;"`;
    } else {
      readStyleHtml = `style="background-color: white;font-weight: bold;"`;
    }

    // let people;
    // if (data.receiver == user_id) {
    //   people = data.sender_email;
    // } else {
    //     people = data.sender_email + " to: " + data.receiver_email;
    // }

    return `<tr ${readStyleHtml} onclick="row(this)">
            <td><input type="checkbox"/></td>
            <td onclick="starClick(this)">${starHtml}</td>
            <td>${sender_email}</td>
            <td><p>${data.subject} - ${data.content}</p></td>
            <td>${data.updated_at}</td>
          </tr>`;
  });
  return htmls;
};

// Hàm đánh dấu sao
// starClick = (star) => {
//   var icon = $(star).find("i");
//   icon.removeClass("fa-star");
//   icon.addClass("fa-heart");
// };

// row = () => {};
