const dom = {}

function getProductIds(){
  const products = document.querySelectorAll('.product-Listing')
  return Array.from(products).map((el) => el.dataset.productId)
}

function replaceProductComingSoon(productId, sizeHtml)
{
  const name = `.product-soon`-${productId}
  const productSoonEls = document.querySelectorAll(name)
  productSoonEls.forEach((el) => {
    const fragment = document.createRange().createContextualFragment(sizeHtml)
    el.replceWith(fragment)
  })
}

dom.
dom.getProductIds = getProductIds

export default dom.replaceProductComingSoon = replaceProductComingSoon
