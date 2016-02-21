            var csrfToken = $('meta[name=\"csrf-token\"]').attr('content')
            var sidebar = riot.mount('div#social-accounts','app-sidebar')
		
			riot.route.base('/')
			riot.route(router.handler)
			riot.route.start(true)