function go_login() {
  if (confirm("로그인후 가능한 서비스입니다.\n로그인페이지로 이동하시겠습니까?")) {
    location.href = "../../member/login.asp";
  }
}

function sendSms(cpnum) {
  $.ajax({
    url: "/proc/liftEvent/proc_Sms.asp",
    dataType: "html",
    method: "POST",
    data: { cpnum: cpnum },
    success: function (result) {},
    error: function (status) {},
  });
}

$(document).ready(function () {
  $(".submit").on("click", function () {
    $(".normal_pop_close").trigger("click");
  });
  //팝업 기본
  $(".btn01").on("click", function () {
    alert("이벤트가 종료되었습니다.");
    return;

    if (chkLogin == "false") {
      go_login();
      return;
    }

    if (is_rotating) {
      alert("잠시만 기다려주세요..");
      return;
    }
    is_rotating = true;

    $.ajax({
      url: "/proc/liftEvent/proc_eventProc.asp",
      dataType: "json",
      method: "POST",
      data: "",
      success: function (result) {
        var divName = "loseDiv";
        if (result.rst == "Y") {
          if (result.graderank != "") {
            $("#rst1").text(result.rst1);
            //$("#rst2").text(result.rst2);
            //$("#rst3").text(result.rst3);
            //$("#rst4").html(result.rst4);
            $("#rst5").attr("src", result.rst5);
            //$("#rst6").text(result.rst2);
            //$("#cpnum").text(result.cpnum);
            divName = "winDiv";
            sendSms(result.cpnum);
          }

          $(".pop_wrap").addClass("on");
          setTimeout(function () {
            $(".popup.motion").addClass("hid");
            $("#" + divName).removeClass("hid");
          }, 2000);
        } else {
          is_rotating = false;
          alert(result.rst);
        }
      },
      error: function (status) {
        is_rotating = false;
      },
    });
  });

  $(".popup .btn.ok,.popup .btn.close").click(function () {
    location.reload();
  });

  $(".event .cont01 .btn02").click(function () {
    if (chkLogin == "false") {
      go_login();
      return;
    }

    $.ajax({
      url: "/proc/liftEvent/eventList.asp",
      dataType: "html",
      method: "POST",
      data: { mobileChk: appMobileUrl },
      success: function (result) {
        $("#gradeList").empty();
        $("#gradeList").html(result);

        $(".event .list").toggleClass("hid");
        $(".event .cont01 .arrow").toggleClass("on");
      },
      error: function (status) {},
    });
  });

  //팝업 기본
  /*
    $(".btn02").on("click", function(){
        if(chkLogin == "false") {
            go_login();
            return;
        }
        layerOpen($(this).attr('rel'))
        gradeList();
    })*/

  $("#gradeList").on("click", ".select_tit", function () {
    var barNum = "barcode" + $(this).attr("num");

    var cpnum = $(this).attr("cpnum");

    generateBarcode(cpnum, barNum);

    if (!$(this).hasClass("on")) {
      $(this).next(".select_cont").stop().slideDown();
      $(this).addClass("on");
    } else {
      $(this).next(".select_cont").stop().slideUp();
      $(this).removeClass("on");
    }
  });
});
