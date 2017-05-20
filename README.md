# G7 Experiment

There's an experimental photo resource already ready to examine. Generate new resources with:

```
rails generate draft:resource whatever col1:datatype col2:datatype...
```

Things to note:

 - There are no instance variables.
 - If we could change it to "zebra" on a whim, we use a string for it; otherwise we use a symbol for it.
 - We never use sensical, simple, conventional variable names; we always append pedantic prefixes or suffixes.
 - You can run `rspec` to make sure that the resource you generated actually works while obeying these crazy rules.
 - You can use the option `--skip-validation-alerts` for a simpler version.
 - You can use the options `--skip-validation-alerts --skip-redirect` for an even simpler version.
