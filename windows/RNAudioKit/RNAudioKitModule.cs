using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Com.Reactlibrary.RNAudioKit
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNAudioKitModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNAudioKitModule"/>.
        /// </summary>
        internal RNAudioKitModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNAudioKit";
            }
        }
    }
}
