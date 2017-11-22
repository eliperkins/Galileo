# Galileo

## Why?

### Existing Libraries

* `react-navigation` isn't native, it reimplements `UINavigationController` and
  friends, so you're fucked every time Apple changes iOS. See iPhone X and how
  it's being handled. Always be binding to native components, not reimplementing
  them.
* `react-native-navigation` is too generic. It binds to `UINavigationController`
  and crew, but has an fairly imperative API, requires screens be registered,
  and handles a lot of the view controller logic at the native level rather than
  leveraging the fact that `UINavigationController`, `UITabBarController` and
  friends are all `UIView`s, so we can still create a sane hierarchy with them
  in React Native without becoming so convoluted. Additionally, it favors
  cross-platform approaches and is a pretty scary codebase.
* `native-navigation` has been abandoned.

## What Do I Want?

* Render props! Pass functions to components that can be called to do navigation
  declaratively rather than imperatively. Downshift is a big inspiration here.
* Smaller bindings for `UINavigationController` and `UITabBarController` and
  their respective sibling classes, creating sane abstractions that allow for
  features to be added on without diving through a Massive View Controller base
  class.
* Leverage the fact `UINavigationController` and `UITabBarController` are just
  `UIView`s, so they can be embedded anywhere in a view hierarchy.

## API

Just spewing out some ideas here. Still a work in progress.

```js
// One, Two, and Three are just plain React Native components.
import { One, Two, Three } from './js/react-components';

// Each of these creates a new VC with a Galileo.View and passes props to Component.
type RenderProps<T> = {
  // Calls self.navigationController.push,
  push: (Component: React.ComponentType<T>, props: T) => void,
  // Calls self{.parentViewController?}.show
  show: (Component: React.ComponentType<T>, props: T) => void,
  // Calls self{.parentViewController?).present
  present: (Component: React.ComponentType<T>, props: T) => void,
};

// Main screen, maps to a plain UIViewController or fragment
// Using render props here lets us pass navigation functions to child components
<Galileo.View
  render={({
    push,
    show,
    present,
  }) => (
    <TouchableOpacity onPress={() => push(Two, { id: 'abc' }})}>
      <Text>Go to next screen</Text>
    </TouchableOpacity>
  )}/>

// Calls down to [[UIBarButtonItem alloc] -initWithBarButtonSystemItem:target:action:], etc
<Galileo.BarButtonItem systemItem="add" onPress={() => console.log('pressed')} />
<Galileo.BarButtonItem title="Jump" onPress={() => console.log('pressed')} />
<Galileo.BarButtonItem image={require('icon.png')} onPress={() => console.log('pressed')} />
// Calls down to [[UIBarButtonItem alloc] -initWithCustomView:]
<Galileo.BarButtonItem
  render={({
    push,
    show,
    present
  }) => (
    <TouchableOpacity onPress={() => push(Two)}>
      <CustomComponent />
    </TouchableOpacity>
  )}/>

<Galileo.View renderLeftBarButtonItems={() => /* TODO: not sure how to handle an array here */} />

// Plain [[UINavigationController alloc] initWithRootViewController]
<Galileo.Navigator RootComponent={One} />

// [[UINavigationController alloc] initWithNavigationBarClass:nil toolbarClass:nil]
// followed by setViewControllers
// TODO: How do props get passed to One and Two here? Maybe this should be a render prop?
<Galileo.Navigator RootComponent={[One, Two]} />

// This is a solved problem and UITabBarController is kinda declarative already
<Galileo.TabBar initialSelectedIndex={1}>
  // Each of these attaches a tabBarItem to the RootComponent view controller
  <Galileo.Tab
    RootComponent={One}
    title="One"
    image={require('icon-one.png')} />
  <Galileo.Tab
    RootComponent={Two}
    systemItem="recents" />
  <Galileo.Tab
    RootComponent={Three}
    title="Three"
    image={require('icon-three.png')
    selectedImage={require('icon-three.png')}
  />
</Galileo.TabBar>
```
