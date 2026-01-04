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

#let larger(body) = {
  text(size: 1.2em)[#body]
}

#let smaller(body) = {
  text(size: 0.833em)[#body]
}

