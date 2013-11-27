package socnet

class UserStopController {
    def profileService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        if (session.user)
        {
            def wordList = []
            wordList = UserStop.findByApiKey(session.user.apiKey)
            if (!wordList) {
                wordList = []
            }
            params.max = Math.min(params.max ? params.int('max') : 10, 100)
            [userStopInstanceList: wordList, userStopInstanceTotal: wordList.count()]
        }
        else
        {
            redirect(controller:"api", action:"demo")
        }
    }

    def create = {
        if (session.user)
        {
            def userStopInstance = new UserStop()
            userStopInstance.properties = params
            userStopInstance.apiKey = session.user.apiKey
            return [userStopInstance: userStopInstance]
        }else
        {
            redirect(controller:"api", action:"demo")
        }
    }

    def save = {
        if (session.user)
        {
            def userStopInstance = new UserStop(params)
            if (userStopInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'userStop.label', default: 'UserStop'), userStopInstance.id])}"
                redirect(action: "show", id: userStopInstance.id)
            }
            else {
                render(view: "create", model: [userStopInstance: userStopInstance])
            }
        }
    }

    def show = {
        if (session.user)
        {
            def userStopInstance = UserStop.findByApiKey(session.user.apiKey)
            if (!userStopInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userStop.label', default: 'UserStop'), params.id])}"
                redirect(action: "list")
            }
            else {
                [userStopInstance: userStopInstance]
            }
        }
    }

    def edit = {
        if (session.user)
        {
            def userStopInstance = UserStop.findByApiKey(session.user.apiKey)
            if (!userStopInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userStop.label', default: 'UserStop'), params.id])}"
                redirect(action: "list")
            }
            else {
                return [userStopInstance: userStopInstance]
            }
        }
    }

    def update = {
        if (session.user)
        {
            def userStopInstance = UserStop.findByApiKey(session.user.apiKey)
            if (userStopInstance) {
                if (params.version) {
                    def version = params.version.toLong()
                    if (userStopInstance.version > version) {
                    
                        userStopInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'userStop.label', default: 'UserStop')] as Object[], "Another user has updated this UserStop while you were editing")
                        render(view: "edit", model: [userStopInstance: userStopInstance])
                        return
                    }
                }
                userStopInstance.properties = params
                if (!userStopInstance.hasErrors() && userStopInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'userStop.label', default: 'UserStop'), userStopInstance.id])}"
                    redirect(action: "show", id: userStopInstance.id)
                }
                else {
                    render(view: "edit", model: [userStopInstance: userStopInstance])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userStop.label', default: 'UserStop'), params.id])}"
                redirect(action: "list")
            }
        }
    }

    def delete = {
        if (session.user)
        {
            def userStopInstance = UserStop.findByApiKey(session.user.apiKey)
            if (userStopInstance) {
                try {
                    userStopInstance.delete(flush: true)
                    flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'userStop.label', default: 'UserStop'), params.id])}"
                    redirect(action: "list")
                }
                catch (org.springframework.dao.DataIntegrityViolationException e) {
                    flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'userStop.label', default: 'UserStop'), params.id])}"
                    redirect(action: "show", id: params.id)
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userStop.label', default: 'UserStop'), params.id])}"
                redirect(action: "list")
            }
        }
    }
}
