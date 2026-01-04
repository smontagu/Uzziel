#let epigraph(quotation, source: "") = {
  align(left)[
    #block(
      width: 55%,
      spacing: 2.5em,
      [
        #align(right)[#text(size: 0.9em)[#quotation]]
        #line(length: 100%)
        #align(left)[#text(size: 0.9em)[#source]]
      ]
    )
  ]
}

#let poem(body) = {
  set par(
    justify: false,
    spacing: 1em,
    first-line-indent: 0em,
  )
  pad(x: 1em)[#body]
}

#let stars = {
  par(
     spacing: 0.75em,
     [#h(1fr)★
      #h(1fr)★
      #h(1fr)★
      #h(1fr)]
  )
}

// tweak Hebrew number
#let renumber(number) = {
  if number.contains("׳") {
    return number.slice(0, -2)
  } else if number.contains("״"){
    return number.slice(0, -4) + number.slice(-2)
  } else {
    return number
  }
}

#let firstLetterBigAndBold(word) = {
  let firstLetter = word.slice(0, 2)
  let rest = word.slice(2)
  text(size: 1.4em)[*#firstLetter*]
  text[#rest]
 
}
#let fLBAB = firstLetterBigAndBold

#let larger(body) = {
  text(size: 1.2em)[#body]
}

#let smaller(body) = {
  text(size: 0.833em)[#body]
}

