let shownPlayers = [];

window.addEventListener('message', function (event) {
  const data = event.data;
  if (data.msg === "Open") {
    $(".wn").css({ display: 'block' });
  }
  if (data.msg === "Close") {
    $(".wn").css({ display: 'none' });
  }
  if (data.msg === "Info") {
    const gender = (data.sex === "m" || data.sex === "0") ? "Male" : "Female";
    const dataHtml = `
      <div class="Player">
        <div class="PlayerInfo" style="left: 1.5rem;">${gender}</div>
        <div class="PlayerInfo" style="left: 10.1rem; width: 11.75rem;">${data.firstname}</div>
        <div class="PlayerInfo" style="left: 23.5rem; width: 6.875rem;">${data.jobs}</div>
        <div class="PlayerInfo" style="left: 35.5rem; width: 8.1875rem;">${data.phone}</div>
        <div class="DelButton" onclick="deletePlayer(this)">
          <p class="PlayerInfo" style="left: -0.65rem; top: -1rem;">Delete</p>
        </div>
      </div>
    `;
    
    if (shownPlayers.indexOf(data.phone) === -1) {
      $('.PlayerBG').append(dataHtml);
      shownPlayers.push(data.phone);
    }
  }
});

function deletePlayer(el) {
  const $player = $(el).closest(".Player");
  const phone = $player.find(".PlayerInfo").eq(3).text();
  $.post(`https://${GetParentResourceName()}/DeletePlayer`, JSON.stringify({ phone }));
  $player.remove();
}

$(document).on('keydown', function(event) {
  if (event.keyCode === 27) { // ESC
    $.post(`https://${GetParentResourceName()}/Close`);  
  }
});
