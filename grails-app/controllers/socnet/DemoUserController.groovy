package socnet

class DemoUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def makeContact = {
        def loggedinDemoUser = DemoUser.findByIdentity("123456")
        if (!loggedinDemoUser) {
            render(view: "error",controller)
            return
        }
        render(view: "contact", model: [demoUserInstance: loggedinDemoUser,demoUserInstanceList: DemoUser.list(params) ])
    }
    def faq = {
        return
    }
    def apiusage = {
        return
    }

    def viewIndex = {
        def loggedinDemoUser = DemoUser.findByIdentity("123456")
        if (!loggedinDemoUser) {
            render(view: "error")
        }
        render(view: "viewindex", model: [demoUserInstance: loggedinDemoUser,demoUserInstanceList: DemoUser.list(params) ])
    }

    def stemText = {
        def loggedinDemoUser = DemoUser.findByIdentity("123456")
        if (!loggedinDemoUser) {
            render(view: "error")
        }
        render(view: "stemtext", model: [demoUserInstance: loggedinDemoUser ])
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [demoUserInstanceList: DemoUser.list(params), demoUserInstanceTotal: DemoUser.count()]
    }

    def create = {
        def demoUserInstance = new DemoUser()
        demoUserInstance.properties = params
        return [demoUserInstance: demoUserInstance]
    }

    def save = {
        def demoUserInstance = new DemoUser(params)
        if (demoUserInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'demoUser.label', default: 'DemoUser'), demoUserInstance.id])}"
            redirect(action: "show", id: demoUserInstance.id)
        }
        else {
            render(view: "create", model: [demoUserInstance: demoUserInstance])
        }
    }

    def show = {
        def demoUserInstance = DemoUser.get(params.id)
        if (!demoUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'demoUser.label', default: 'DemoUser'), params.id])}"
            redirect(action: "list")
        }
        else {
            [demoUserInstance: demoUserInstance]
        }
    }

    def edit = {
        def demoUserInstance = DemoUser.get(params.id)
        if (!demoUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'demoUser.label', default: 'DemoUser'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [demoUserInstance: demoUserInstance]
        }
    }

    def update = {
        def demoUserInstance = DemoUser.get(params.id)
        if (demoUserInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (demoUserInstance.version > version) {
                    
                    demoUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'demoUser.label', default: 'DemoUser')] as Object[], "Another user has updated this DemoUser while you were editing")
                    render(view: "edit", model: [demoUserInstance: demoUserInstance])
                    return
                }
            }
            demoUserInstance.properties = params
            if (!demoUserInstance.hasErrors() && demoUserInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'demoUser.label', default: 'DemoUser'), demoUserInstance.id])}"
                redirect(action: "show", id: demoUserInstance.id)
            }
            else {
                render(view: "edit", model: [demoUserInstance: demoUserInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'demoUser.label', default: 'DemoUser'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def demoUserInstance = DemoUser.get(params.id)
        if (demoUserInstance) {
            try {
                demoUserInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'demoUser.label', default: 'DemoUser'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'demoUser.label', default: 'DemoUser'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'demoUser.label', default: 'DemoUser'), params.id])}"
            redirect(action: "list")
        }
    }
}
