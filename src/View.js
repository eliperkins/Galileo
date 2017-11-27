/* @flow */

import * as React from 'react';
import ReactNative, {
  NativeModules,
  requireNativeComponent,
} from 'react-native';

// Each of these creates a new VC with a Galileo.View and passes props to Component.
type RenderProps<T> = {
  // Calls self.navigationController.push,
  push: (Component: React.ComponentType<T>, props: T) => void,
  // Calls self{.parentViewController?}.show
  show: (Component: React.ComponentType<T>, props: T) => void,
  // Calls self{.parentViewController?).present
  present: (Component: React.ComponentType<T>, props: T) => void,
};

type Props = {
  render: (props: RenderProps<any>) => React.Element<any>,
};

class View extends React.Component<Props> {
  pushView(Component: React.ComponentType<any>) {
    const tag = ReactNative.findNodeHandle(this);
    const nextView = React.createElement(Component, {}, null);
    const nextViewTag = ReactNative.findNodeHandle(nextView);
    NativeModules.GLLViewManager.pushOnViewWithTag(tag, nextViewTag, () =>
      console.log('done pushing'),
    );
  }
  render() {
    return (
      <GLLView onPush={() => {}} {...this.props}>
        {this.props.render({
          push: Component => {
            console.log('pushing');
            this.pushView(Component);
          },
          show: () => {
            console.log('showing');
          },
          present: () => {
            console.log('presenting');
          },
        })}
      </GLLView>
    );
  }
}

const GLLView = requireNativeComponent('GLLView', null);

export default View;
