# 15. Model training with Create ML: Train a Core ML model

## CreateML

예제 csv로 trail 위험도 예측하는 ML 만들기
입력값을 기반으로 출력값을 예측하는 회귀분석 Tabular Regression 템플릿 사용

### 1. Settings 분석 기반 설정

<p><img width="811" height="458" alt="Image" src="https://github.com/user-attachments/assets/8ea6eac0-06a4-4600-a3d4-aa6f7f39d8c0" /></p>

- Training Data: 훈련에 사용할 데이터 / Testing Data: 훈련된 모델을 테스트할 데이터
- Target: 예측 분석할 대상 (risk)
- Features: 타겟에 영향을 주는 요소
### 2. Training 모델 학습
### 3. Evaluation 오류율 평가

  추후 이해해보기. .

  The root mean square error represents the error across the entire model. Since it is necessarily lower than the maximum error, you can be confident that the model predicts the risk according to the training data.
  Good models produce higher errors when the training data isn’t perfectly consistent. Real world data has outliers and errors. In such cases, evaluate a model by asking “Is the prediction useful?” rather than “Is the prediction correct?”

### 4. Preview 테스트

<p><img width="647" height="220" alt="Image" src="https://github.com/user-attachments/assets/b8182c65-3a44-4c82-9171-a81cbe51d79d" /></p>

### **알고리즘 유형**

- Decision Tree
- Boosted Tree
- Random Forest
- Linear Regression

### 선형회귀(위)와 의사결정나무(아래) 오차율 비교

→ CreateML은 인풋 데이터에 적합한 훈련 알고리즘을 자동으로 채택한다.

<p><img width="80%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/4275e6fc-da7e-4852-b3d1-a38267d412fa" /><img width="80%" height="auto" alt="Image" src="https://github.com/user-attachments/assets/7f50cc38-1386-421e-9425-929de77106ff" /></p>
