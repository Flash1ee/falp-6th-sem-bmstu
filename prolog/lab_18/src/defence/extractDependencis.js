var normalizeVersion = (v) => {
    var splitted = v.split(".").slice(0, 3)
    return splitted.join(".") + ".0".repeat(3 - splitted.length)
}

var dependenciesHeader = document.evaluate("//th[contains(., 'Dependencies')]", document, null, XPathResult.ANY_TYPE, null ).iterateNext();
var dependenciesList = Array.from(dependenciesHeader.parentElement.children[1].children).slice(0, -1);
var dependenciesConverted = dependenciesList.map(item => {
    var package = item.querySelector("a").innerText;

    if (item.childNodes.length == 1) {
        return `dependOn("${package}")`
    }

    var query = item.childNodes[1].data.trimStart().slice(1, -1);
    var orSelector = query.
        split("||").map(query => 
            query.trim()
            .replace(/>=([\.\d]+)/g, `ge("$1")`)
            .replace(/==([\.\d]+)/g, `eq("$1")`)
            .replace(/<([\.\d]+)/g, `lt("$1")`)
            .replace(/(.+) && (.+)$/g, "and([$1, $2])")
            .replace(/([\.\d]+)/g, normalizeVersion)
            )
    
    if (orSelector.length === 1) {
        return `dependOn("${package}", ${orSelector[0]})`
    }
    
    return `dependOn("${package}", or([${orSelector.join(", ")}]))`
})

var versionHeader = document.evaluate("//th[contains(., 'Versions')]", document, null, XPathResult.ANY_TYPE, null ).iterateNext();
var version = normalizeVersion(versionHeader.parentElement.querySelector("strong").innerText)
var packageName = document.querySelector("h1 a").innerText

console.log(`
package("${packageName}", "${version}", [
  ${dependenciesConverted.join(",\n  ")}
]).
`)