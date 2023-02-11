export def parse_document [] {
    let lines = ($in | lines)
    let parts = ($lines | split list "---")
    let post = {
        body: ($parts | last | str join "\n" | to_html),
    }

    if ($parts | length) == 1 {
        return $post
    }

    let front_matter = (
        $parts |
        first |
        str join "\n" |
        from yaml
    )

    $front_matter | merge $post
}

def to_html [] {
    ^pandoc -f markdown -t html
}
