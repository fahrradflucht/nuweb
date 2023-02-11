#!/usr/bin/env nu

use lib/cgi.nu
use lib/markdown.nu
use templates.nu

def main [] {
    let posts = (ls "posts" | each { |file|
        (open --raw $file.name | markdown parse_document)
    })

    cgi render_response {
        "status": 200,
        "headers": { "Content-Type": "text/html" },
        "body": (templates home {
            date: (date now | date format "%Y-%m-%d"),
            posts: $posts
        })
    }
}
