// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
import "../css/app.css"
import {productSocket} from "./socket"
import dom from './dom'
// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

const productIds = [] //dom.getProductIds()
//const prod = document.getElementsByClassName("product-listing")
let getprod = document.querySelectorAll("[id=proid]")
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

//-----------bt-------bt-------bt---------
// productChannel.on('stock_change', ({product_id, item_id, level }) =>{dom.upddateItemLevel(item_id, level)})

for (let i = 0; i < getprod.length; i++) {
  productIds[i] = getprod[i].getAttribute("value")
}
if (productIds.length > 0){
    productSocket.connect()
  productIds.forEach((id) => setupProductChannel(productSocket, id)
)}
function setupProductChannel(socket, productId) {
  const productChannel = socket.channel(`product: ${productId}`)
  productChannel.join()
  .receive("error", () => {
    console.error("Channel join failed")
  })
  productChannel.on('released',({size_html}) => {
    dom.replaceProductComingSoon(productId, size_html)
  })
}
//-----------bt-------bt-------bt---------

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page

liveSocket.connect()
window.liveSocket = liveSocket
// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
