// Extension
Extension:        Extension1
Id:               Extension-1
Title:            "Title"
Description:      "Desc"
* value[x] ^short = "short..."
* value[x] 1..1 MS
* value[x] only canonical

//target for extensions valueCanonical
Profile: CompositionOutput
Parent: Composition 
Id: composition2

//Throws error 
Profile:        CompositionOutput2
Parent:         Composition
Id:             composition
Title:          "Composition"
Description:    "A profile on the Composition resource"
* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "$this"
* section ^slicing.rules = #open
* section contains 
    section1 0..1 MS

* section[section1].section ^slicing.discriminator.type = #pattern
* section[section1].section ^slicing.discriminator.path = "$this"
* section[section1].section ^slicing.rules = #open
* section[section1].section contains 
    section2 0..1 MS

* section[section1].section[section2].extension contains Extension1 named abc 0..1 MS
* section[section1].section[section2].extension[abc].valueCanonical = Canonical(CompositionOutput)




