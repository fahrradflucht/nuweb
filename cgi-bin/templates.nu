def render_post [post] {($'
<article>
    <h2>($post.title)</h2>
    <div class="post-meta">
        <p>Published <time>($post.date | into datetime | date humanize)</time></p>
        <p>Written By ($post.author)</p>
    </div>
    <div class="post-body">
        ($post.body)
    </div>
</article>
' | str trim)}

export def home [data] {
let title = "Nushell Blog"

($'<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>($title)</title>
    <style>
        article {
            display: grid;
        }
        .post-meta {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <div>
        <h1>($title)</h1>
        ($data.posts | each {|post| render_post $post} | str join)
    </div>
</body>
</html>
' | str trim)}