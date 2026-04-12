//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by 강서현 on 3/28/26.
//

import SwiftUI

struct ContentView: View {
    @State private var names: [String] = []
    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedName = false
    
    var body: some View {
        VStack {
            VStack(spacing: 8){
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(.tint)
                    .symbolRenderingMode(.hierarchical)
                Text("Pick-a-pal")
                    .font(.title)
                    .bold()
            }
            
            
            Text(pickedName.isEmpty ? " " : pickedName)
            //단일 공백 사용시, 공백이어도 일정 공간 유지
            // isEmpth ?(true이면), " " , 아니면 pickedName
                .font(.title2)
                .bold()
                .foregroundStyle(.tint)
            
            List{
                ForEach(names, id: \.description) { name in Text(name)
                }
                //반복 실행하려는 코드를 파라미터로 받고, 콜렉션에 저장된 요소를 코드 돌려서 클로저 상수(결과)로 넘겨줌 == 클로저 바디!! 원래 ()->() in~ 이거 같음
                //클로저도 함수. { } 로 감싸진 실행 가능한 코드 블럭
                //self 숫자 desc 문자
                //여기서 in은 범위가 아니라 내가 출력하려는 것
                
                //엔터return 치면 실행
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            TextField("Add Name", text: $nameToAdd)
            //$바인딩
                .autocorrectionDisabled()
                .onSubmit {
                    if !nameToAdd.isEmpty{
                        // ! << ~하지 않으면
                        names.append(nameToAdd)
                        nameToAdd = ""
                        // nameToAdd를 공백으로 초기화
                    }
                }
            
            Divider()
            
            Toggle("Remove when Picked", isOn: $shouldRemovePickedName)
            
            Button {
                if let randomName = names.randomElement() {
                    pickedName = randomName
                    
                    if shouldRemovePickedName {
                        names.removeAll {
                            name in (name == randomName)
                        }
                    }
                } else {
                    pickedName = ""
                }
            } label: {
                    Text("Pick Random Name")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                }
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
