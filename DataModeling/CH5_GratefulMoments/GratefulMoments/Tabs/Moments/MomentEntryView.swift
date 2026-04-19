//
//  MomentEntryView.swift
//  GratefulMoments
//
//  Created by 강서현 on 4/19/26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct MomentEntryView: View {
    @State private var title = ""
    @State private var note = ""
    @State private var newImage: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var isShowingCancleConfirmation = false
    
    
    @Environment(DataContainer.self) private var dataContainer
    // 데이터 컨테이너 밖에서 끌어오기
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ScrollView {
                contentStack
                photoPicker
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Grateful For")
            .toolbar {
                // 저장
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark"){
                        let newMoment = Moment(
                            title: title,
                            note: note,
                            ImageData: imageData,
                            timestamp: .now
                        )
                        modelContext.insert(newMoment)
                        try? modelContext.save()
                        
                        dismiss()
                        isShowingCancleConfirmation = true
                    }
                    .confirmationDialog("Discard Moment", isPresented: $isShowingCancleConfirmation){
                        Button("DisCardMoment", role: .destructive) {
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty)
                    .tint(.accent)
                }
                // 취소
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancle", systemImage: "xmark"){
                        if title.isEmpty, note.isEmpty, imageData == nil {
                            dismiss()
                        } else {
                            isShowingCancleConfirmation = true
                        }
                    }
                }
                
            }
        }
    }
    
    
    // 임시 레이아웃
    private var contentStack: some View {
        VStack(alignment: .leading) {
            TextField("Title(Required)", text: $title)
                .font(.title)
                .bold()
            Divider()
            TextField("Log your small wins", text: $note, axis: .vertical)
                .lineLimit(5)
        }
        .padding()
        .padding(.bottom, 80)
    }
    
    private var photoPicker: some View {
        // 사진 라이브러리를 호출하는 PhotosPicker
        PhotosPicker(selection: $newImage){
            Group {
                if let imageData, let uiImage = UIImage(data: imageData){
                    // imageData는 바이트 데이터이므로 화면에 그릴 이미지 객체로 만들기 위해 UI Image로 변환
                    // UIImage는 UI kit에서 이미지를 그리는 방식. swiftUI로 옮기기 위해 Image()로 감싸주기
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.badge.plus.fill")
                        .foregroundStyle(.accent)
                        .font(.largeTitle)
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .background(Color(white: 0.4, opacity: 0.32))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding()
            // 비동기로 사진을 불러오는 Task
            .onChange(of: newImage) {
                guard let newImage else { return }
                Task {
                    imageData = try? await newImage.loadTransferable(type: Data.self)
                }
            }
        }
        
    }
    
    
}

extension View{
    func sampleDataContainer() -> some View {
        let dataContainer = DataContainer(includeSampleMoments: true)
        return self
            .environment(dataContainer)
            .modelContainer(dataContainer.modelContainer)
    }
}

#Preview {
    MomentEntryView().sampleDataContainer()
}
