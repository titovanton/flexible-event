(($) ->
    $.cookie.json = true

    $.sendTabMsg = (msg, path='/') ->
        data = new Object
        data.msg = msg
        now = new Date()
        data.date = "#{now.getFullYear()}-#{now.getMonth()+1}-#{now.getDate()}"
        data.date += " #{now.getHours()}:#{now.getMinutes()}:#{now.getSeconds()}"
        data.date += ".#{now.getMilliseconds()}"
        $.cookie 'tabMsg', data, path:path

)(jQuery)

jQuery () ->
    setInterval () ->
        tabMsg = $.cookie 'tabMsg'

        if tabMsg?
            if document.tabMsg?
                if document.tabMsg.date < tabMsg.date
                    document.tabMsg = tabMsg
                    $(document).trigger 'tabMsg.happend', tabMsg
            else
                document.tabMsg = tabMsg
                $(document).trigger 'tabMsg.happend', tabMsg

    , 100

    $(document).bind 'tabMsg.happend', (eventObj, tabMsg) ->
        if document.tabMsgLogging? and document.tabMsgLogging
            console.log tabMsg
