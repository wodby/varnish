# In the event of an error, show friendlier messages.
sub vcl_backend_error {
  set beresp.http.Content-Type = "text/html; charset=utf-8";
  synthetic ({"
<html>
<head>
    <title>Not Found</title>
    <style type="text/css">
        A:link {text-decoration: none;  color: #333333;}
        A:visited {text-decoration: none; color: #333333;}
        A:active {text-decoration: none}
        A:hover {text-decoration: underline;}
    </style>
</head>
<body onload="setTimeout(function() { window.location.reload() }, 5000)" bgcolor=white text=#333333 style="padding:5px 15px 5px 15px; font-family: myriad-pro-1,myriad-pro-2,corbel,sans-serif;">
<H3>Page Unavailable</H3>
<p>The page you requested is temporarily unavailable.</p>
</body>
</html>
"});
  return (deliver);
}
