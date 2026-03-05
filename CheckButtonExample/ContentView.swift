//
//  ContentView.swift
//  CheckButtonExample
//
//  Created by Yasin Al-Hammadi on 05.03.26.
//

import SwiftUI
import CheckButton

// MARK: Model

enum Gender: String, Choiceable {
    case male, female, diverse
    
    var id: Self { self }
    var title: String { return self.rawValue.capitalized }
}

enum Choice: String, Choiceable {
    case none, one, two, three
    
    var id: Self { self }
    var title: String { return self.rawValue.capitalized }
}

enum Hobby: String, Choiceable {
    case cooking, hiking, painting, reading, sport, yoga
    
    var id: Self { self }
    var title: String { return self.rawValue.capitalized }
}

// MARK: - View

struct ContentView: View {
    
    @State private var choice: Choice = .none
    @State private var gender: Gender? = nil
    @State private var hobbies: [Hobby] = []
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    radioButtons1Group
                    Divider()
                    radioButtons2Group
                    Divider()
                    checkButtonsGroup
                }
                .padding()
            }
            .navigationTitle("Check Button Example")
            
        }
    }
    
}

// MARK: - Checkboxes Components

extension ContentView {
    // MARK: - Radio Group 1
    // Circular checkbox, single choice, small circular blue checkmark

    @ViewBuilder
    private var radioButtons1Group: some View {
        VStack(alignment: .leading) {
            Text("Radio Group 1: Only One Selection")
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Choice")
                .bold()
            
            let radioConfig = CheckButtonConfig(
                shape: .circle,
                checkmarkType: .circle,
                multipleChoice: false,
                markSize: .small,
                color: .white,
                borderColor: .gray,
                markedBackground: .blue)
            CheckButtonGroup(items: Choice.self,
                             selections: [choice],
                             config: radioConfig) { selections in
                if let selection = selections.first {
                    choice = selection
                }
            }
            .padding(.leading, 40)
            .overlay(alignment: .topTrailing) {
                Text("Choice:\n\(choice.title)")
                    .padding()
                    .background(Color.black.opacity(0.05))
            }
        }
        .padding(.vertical)
    }
    
    // MARK: - Radio Group 2
    // Circular checkbox, single choice, default circular green checkmark
    
    @ViewBuilder
    private var radioButtons2Group: some View {
        VStack(alignment: .leading) {
            Text("Radio Group 2: Only One Selection")
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Gender")
                .bold()
            
            let radioConfig = CheckButtonConfig(
                shape: .circle,
                checkmarkType: .circle,
                multipleChoice: false,
                color: .secondary.opacity(0.4),
                borderColor: .secondary.opacity(0.6),
                markedBackground: .green)
            CheckButtonGroup(items: Gender.self,
                             config: radioConfig) { selections in
                gender = selections.first
            }
            .padding(.leading, 40)
            .overlay(alignment: .topTrailing) {
                if let gender {
                    Text("Gender:\n\(gender.title)")
                        .padding()
                        .background(Color.black.opacity(0.05))
                }
            }
        }
        .padding(.vertical)
    }
    
    // MARK: - CheckBox Group
    // Square checkbox, multiple choices, checkmark with custom size
    
    @ViewBuilder
    private var checkButtonsGroup: some View {
        VStack(alignment: .leading) {
            Text("Check Box Group: Multiple Choice")
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Hobbies")
                .bold()
            
            let checkConfig = CheckButtonConfig(
                shape: .square,
                checkmarkType: .checkmark,
                multipleChoice: true,
                markSize: .custom(size: 12),
                color: .black.opacity(0.1),
                borderColor: .black.opacity(0.2),
                markedBackground: .black,
                markedForeground: .white)
            CheckButtonGroup(items: Hobby.self,
                             selections: hobbies,
                             config: checkConfig) { selections in
                hobbies = selections
            }
            .padding(.leading, 40)
            .overlay(alignment: .topTrailing) {
                if !hobbies.isEmpty {
                    VStack {
                        Text("Selection:")
                            .padding(.bottom)
                        ForEach(hobbies) { hobby in
                            Text(hobby.title)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.05))
                }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    ContentView()
}
