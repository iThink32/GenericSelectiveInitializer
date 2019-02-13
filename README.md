# GenericSelectiveInitializer
A class that shows you how to selectively initialise optional instance variables and get their unwrapped value

## Use case :-

have you ever faced an issue in which you had optionals in a class and wanted to initialize them generically at different
places in your source code and later directly get the unwrapped value?
This repo shows you how.

##Usage :-

Consider the class in the repo , it has two simple funcs

```swift
    func initializeWith<T>(keypath:ReferenceWritableKeyPath<GenericSelectiveInitializer,T>,value:T) {
        self[keyPath:keypath] = value
    }
```

This func is can generically initialize any instance varible via keypaths like

```swift
        var obj = GenericSelectiveInitializer()
        obj.initializeWith(keypath: \GenericSelectiveInitializer.a, value: 12)
```

and the other func is 

```swift
    func valueFrom<ReturnType,Type>(keyPath:KeyPath<GenericSelectiveInitializer,Type>,defaultValue:ReturnType) -> ReturnType {
        let value = self[keyPath:keyPath]
        let mirror = Mirror(reflecting: value)
        guard mirror.displayStyle == Mirror.DisplayStyle.optional,mirror.children.count == 1,let child = mirror.children.first?.value as? ReturnType else{
            return defaultValue
        }
        return child
    }
```

This func gets you the unwrapped value without having to use an if let or guard via reflection :p like

```swift
print(obj.valueFrom(keyPath: \GenericSelectiveInitializer.a, defaultValue: 14))
```

i agree you are still providing a default value but this is the max i can help as of now , will update as new ideas flow through :)

