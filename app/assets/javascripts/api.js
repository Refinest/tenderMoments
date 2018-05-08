//= require_tree ../../../vendor/assets/javascripts/swagger-ui/.

window.onload = function() {
  // Build a system
  const ui = SwaggerUIBundle({
    url: "http://localhost:3000/api/v1/doc/swagger",
    dom_id: '#swagger-ui',
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout"
  })

  window.ui = ui
}