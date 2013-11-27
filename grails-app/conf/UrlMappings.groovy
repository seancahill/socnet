class UrlMappings {

    static mappings = {
		"/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }

        "/api/profile/$id"(controller:"api"){ action = [POST:"profile",GET:"profile"] }
        "/api/profileFormatted/$id"(controller:"api"){ action = [POST:"profileFormatted",GET:"profileFormatted"] }
        "/api/match/$id"(controller:"api"){ action = [POST:"match"] }
        "/api/delete/$id"(controller:"api"){ action = [POST:"delete"] }
        "/api/collaborate/$id"(controller:"api"){ action = [POST:"collaborate"] }
        "/api/compare/$id"(controller:"api"){ action = [POST:"compare"] }
        "/user/confirm/$id"(controller:"api"){ action = [GET:"confirm"] }
        "/api/likes/$id"(controller:"api"){ action = [POST:"likes"] }
        "/api/stemToKeywords/$id"(controller:"api"){ action = [POST:"stemToKeywords"] }
	"/"(view:"/index")
	"500"(view:'/error')
        "404"(view:'/error')
    }
}
