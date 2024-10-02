//
//  WorkoutWidgetBundle.swift
//  WorkoutWidget
//
//  Created by Akhil Naru on 4/2/24.
//

import WidgetKit
import SwiftUI

@main
struct WorkoutWidgetBundle: WidgetBundle {
    var body: some Widget {
        WorkoutWidget()
        WorkoutWidgetLiveActivity()
    }
}
