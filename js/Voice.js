var zenith = zenith || {};
zenith.Voice = (function () {
    const client = new ApiAi.ApiAiClient({accessToken: 'ada2581758904a9080d1c2b62e3337d8'});
    const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    const recognition = new SpeechRecognition();
    var keepActive;
    recognition.lang = 'en-US';
    recognition.interimResults = false;
    recognition.continuous=true;
    recognition.maxAlternatives = 1;

    recognition.addEventListener('speechstart', () => {
        setVoiceActivationIconToListening();
        console.log('Speech has been detected.');
    });

    recognition.addEventListener('result', (e) => {
        //console.log('Result has been detected.');

        let last = e.results.length - 1;
        let text = e.results[last][0].transcript;

        $("#voice-indicator-icon").attr("title",'"'+text+'"');
        $("#voice-indicator-icon").attr("data-original-title",'"'+text+'"');
        $("#voice-indicator-icon").tooltip('show');        

        var promise = client.textRequest(text);

        promise
            .then(handleResponse)
            .catch(handleError);


    });
    recognition.onstart = function () {
      console.log("I'm listening to you...");
    }
    recognition.onend = function () {
        if (keepActive) {
            recognition.start(); //this keeps the listener open.  By default turns off after a couple minutes.
        }
        else {
            setVoiceActivationIconToInactive();
        }
    }
    recognition.addEventListener('speechend', () => {
        setVoiceActivationIconToIdle();
        recognition.stop();
    });
    recognition.addEventListener('error', (e) => {
      console.log('Error: ' + e.error);
    });

    var init = function () {
        changeVoiceActivationStatus();
    }

    var startListening = function () {
        keepActive=true;
        recognition.start();
        setVoiceActivationIconToActive();
        //setVoiceActivationIconToIdle();
    }

    var stopListening = function () {
        keepActive=false;
        recognition.stop();
    }

    var handleResponse = function (serverResponse) {
        setVoiceActivationIconToIdle();
        zenith.VoiceIntents.search(serverResponse);
    }   
    var handleError = function (serverError) {
        console.log(serverError);
    }

    var changeVoiceActivationStatus = function () {
        if (keepActive == null || keepActive==false) {
            startListening()
        }
        else {
            stopListening();
        }
    }

    var setVoiceActivationIconToActive = function () {
        var icon=$("#voice-indicator-icon");
        icon.removeClass("voice-indicator-pulse-inactive");
        icon.addClass("voice-indicator-pulse-active");
        $(".fa-circle",icon).removeClass("voice-indicator-icon-circle-inactive");
        $(".fa-circle",icon).addClass("voice-indicator-icon-circle-active");
        $(".fa-microphone",icon).removeClass("voice-indicator-icon-mic-inactive");
        $(".fa-microphone",icon).addClass("voice-indicator-icon-mic-active");
    }
    var setVoiceActivationIconToInactive = function () {
        var icon=$("#voice-indicator-icon");
        icon.addClass("voice-indicator-pulse-inactive");
        icon.removeClass("voice-indicator-pulse-active");
        $(".fa-circle",icon).addClass("voice-indicator-icon-circle-inactive");
        $(".fa-circle",icon).removeClass("voice-indicator-icon-circle-active");
        $(".fa-microphone",icon).addClass("voice-indicator-icon-mic-inactive");
        $(".fa-microphone",icon).removeClass("voice-indicator-icon-mic-active");
    }
    function setVoiceActivationIconToIdle () {
        $("#voice-indicator-icon").addClass("voice-indicator-icon-idle");
    }
    function setVoiceActivationIconToListening () {
        $("#voice-indicator-icon").removeClass("voice-indicator-icon-idle");
    }


    return {
        init : init,
        changeVoiceActivationStatus : changeVoiceActivationStatus
    }
}());