//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer

/**
var routes = Routes()
routes.add(method: .get, uri: "/path/one") { req, resp in
    resp.setBody(string: "routes received")
    resp.completed()
}
 */


/*
var routes = Routes()

var apiRoutes = Routes()
apiRoutes.add(method: .get, uri: "/call1") { req, resp in
    resp.setBody(string: "call1")
    resp.completed()
}

apiRoutes.add(method: .get, uri: "/call2") { req, resp in
    resp.setBody(string: "call2")
    resp.completed()
}

var v1Routes = Routes(baseUri: "/v1")
var v2Routes = Routes(baseUri: "/v2") { req, resp in
    print("如果/v2 有一些额外的需求，可以在这里进行，如登录验证等")
    /**
    if authorized(request) {
        response.next()
    } else {
        response.completed(.unauthorized)
    }
     */
    resp.next()
}

// /v2 的 /call2 会覆盖之前的 /call2
v2Routes.add(method: .get, uri: "/call2") { req, resp in
    resp.setBody(string: "new call2")
    resp.completed()
}

v1Routes.add(apiRoutes)
v2Routes.add(apiRoutes)

routes.add(v1Routes)
routes.add(v2Routes)
*/


var routes = Routes()

/// 如下四种路由优先级排序，由高到低

/// 1. 带变量路由路径
routes.add(method: .get, uri: "/foo/{bar}/baz") { req, resp in
    resp.setBody(string: req.uri)
    print(req.uri)
    resp.completed()
}

/// 2. 静态文本路径
routes.add(method: .get, uri: "/foo/1/baz") { req, resp in
    resp.setBody(string: req.uri)
    print(req.uri)
    resp.completed()
}

/// 3. 通配符路径
routes.add(method: .get, uri: "/foo/*/baz") { req, resp in
    resp.setBody(string: req.uri)
    print(req.uri)
    resp.completed()
}

/// 4. 结尾通配符
routes.add(method: .get, uri: "/foo/**") { req, resp in
    resp.setBody(string: req.uri)
    print(req.uri)
    resp.completed()
}


 
do {
    let server = HTTPServer()
    server.serverName = "localhost"
    server.serverPort = 8181
    
    server.addRoutes(routes)
    
    try server.start()
} catch {
    print(error)
}


