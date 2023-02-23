
// COMMAND IF EDITING IN BROWSER
//$('body').hide();
//$('html').hide();


window.addEventListener('message', function(event) {
    if (event.data.type == "OPEN_CHARS") {
        $('html').show();
        $('body').show();
    } 
})

window.addEventListener('message', function(event) {
    if (event.data.type == "UPDATE_INFO") { 
        let namesurname = event.data.firstname + " " + event.data.lastname
        document.getElementById('charname').innerHTML = namesurname;
        document.getElementById('streetnamer').innerHTML = event.data.ulica;
        document.getElementById('leavetime').innerHTML = event.data.leavetime;
        
        if (event.data.leavetime == "00/00/2022 20:30"){
        console.log('kurewko to twoj pierwszy raz')
        document.getElementById('text3').innerHTML = "Miejsca Spawnu";
        document.getElementById('headier').innerHTML = "Witaj";
        document.getElementById('text2').innerHTML = "";
        $('#lasterek').hide();
        $('.blip1').css('margin-top', '-15.5vw')
        $('#buttonchar').css('margin-top', '12.8vw')
        $('#buttonchar2').css('margin-top', '11.4vw')
        }else { 
            document.getElementById('text3').innerHTML = "Inne miejsca";
            document.getElementById('headier').innerHTML = "Witaj ponownie";
            document.getElementById('text2').innerHTML = "Powrot na miejsce";
            $('#lasterek').show();
            $('#buttonchar').css('margin-top', '7.8vw')
            $('#buttonchar2').css('margin-top', '6.4vw')
            $('.blip1').css('margin-top', '-16vw')
        }
       let position = event.data.position //TO DO BLIP
        let pos = JSON.parse(position);
        
    }
})


const ES = {}
    ES.Variable = {}
    ES.Variable.Spawn = {
        name: null,
        id: null,
    }

    ES.Spawn = {}

    ES.Spawn.set = (data)=> {
        if (data) {
            ES.Variable.Spawn["name"] = data.name 
            ES.Variable.Spawn["id"] = data.id 
        }
    }

    ES.Spawn.get = ()=> {
        return ES.Variable.Spawn
    }

$(()=> {

    $(".button").click( e => {
        var target = $(e.target)
        var name = target.data("name")
        var id = target.data("id")
        var json = {
            name: name,
            id: id
        }
        ES.Spawn.set(json)
        $(".button").removeClass("button-click")
        $(e.target).addClass("button-click")
        $('#buttonchar2').fadeIn('slow')
        $('#buttonchar').css('margin-top', '0.5vw')
        if (id == 1){

        }
        if (id == 2){
        $('.blip4').css('background-color', '#634094')
        $('.blip1').css('background-color', '#3e2364')
        $('.blip2').css('background-color', '#3e2364')
        $('.blip3').css('background-color', '#3e2364')
        $('.blip5').css('background-color', '#3e2364')
        $('.blip6').css('background-color', '#3e2364')
        $('.blip7').css('background-color', '#3e2364')
        
        }
        if (id == 3){
            $('.blip4').css('background-color', '#3e2364')
            $('.blip1').css('background-color', '#3e2364')
            $('.blip2').css('background-color', '#3e2364')
            $('.blip3').css('background-color', '#634094')
            $('.blip5').css('background-color', '#3e2364')
            $('.blip6').css('background-color', '#3e2364')
            $('.blip7').css('background-color', '#3e2364')
            
        }
        if (id == 4){
            $('.blip4').css('background-color', '#3e2364')
            $('.blip1').css('background-color', '#3e2364')
            $('.blip2').css('background-color', '#3e2364')
            $('.blip3').css('background-color', '#3e2364')
            $('.blip5').css('background-color', '#634094')
            $('.blip6').css('background-color', '#3e2364')
            $('.blip7').css('background-color', '#3e2364')
        }
        if (id == 5){
            $('.blip4').css('background-color', '#3e2364')
            $('.blip1').css('background-color', '#3e2364')
            $('.blip2').css('background-color', '#634094')
            $('.blip3').css('background-color', '#3e2364')
            $('.blip5').css('background-color', '#3e2364')
            $('.blip6').css('background-color', '#3e2364')
            $('.blip7').css('background-color', '#3e2364')
        }
        if (id == 6){
            $('.blip4').css('background-color', '#3e2364')
            $('.blip1').css('background-color', '#634094')
            $('.blip2').css('background-color', '#3e2364')
            $('.blip3').css('background-color', '#3e2364')
            $('.blip5').css('background-color', '#3e2364')
            $('.blip6').css('background-color', '#3e2364')
            $('.blip7').css('background-color', '#3e2364')
        }
        if (id == 7){
            $('.blip4').css('background-color', '#3e2364')
            $('.blip1').css('background-color', '#3e2364')
            $('.blip2').css('background-color', '#3e2364')
            $('.blip3').css('background-color', '#3e2364')
            $('.blip5').css('background-color', '#3e2364')
            $('.blip6').css('background-color', '#634094')
            $('.blip7').css('background-color', '#3e2364')
        }
        if (id == 8){
            $('.blip4').css('background-color', '#3e2364')
            $('.blip1').css('background-color', '#3e2364')
            $('.blip2').css('background-color', '#3e2364')
            $('.blip3').css('background-color', '#3e2364')
            $('.blip5').css('background-color', '#3e2364')
            $('.blip6').css('background-color', '#3e2364')
            $('.blip7').css('background-color', '#634094')
        }
        
    })
})



//OTHERS
function intogame(){
    $('body').fadeOut('slow');
    $.post(`http://${GetParentResourceName()}/spawn`, JSON.stringify({data: ES.Spawn.get()}))
}
function otherchar(){
$('body').fadeOut('slow');
$.post(`http://${GetParentResourceName()}/changechar`, JSON.stringify({data: ES.Spawn.get()}))
}



//NONE CHARACTER MOMENT
window.addEventListener('message', function(event) {
    if (event.data.type == "NONE_CHAR") {
        $('#buttonchar').hide();
    }
})