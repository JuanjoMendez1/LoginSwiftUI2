//
//  ContentView.swift
//  LoginSwiftUI2
//
//  Created by Juan Jose Mendez Rojas on 16/04/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @AppStorage("log_Status") var status = false
    @StateObject var model = ModelData()
    
    var body: some View {
        
        ZStack{
            if status{
                VStack(spacing: 25){
                    Text("Bienvenido \(Auth.auth().currentUser?.email ?? "")")
                    Button(action: model.logOut, label: {
                        Text("Salir")
                            .fontWeight(.bold)
                    })
                }
            } else{
                LoginView(model: model)
            }
        }
        
//        SignUpView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoginView : View{
    @ObservedObject var model : ModelData
    var body: some View{
        ZStack {
            VStack{
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                ZStack{
                    if UIScreen.main.bounds.height < 750{
                        Image("logoLogin")
                            .resizable()
                            .frame(width: 130, height: 130)
                    } else{
                        Image("logoLogin")
                    }
                }
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(30)
                    .padding(.top)
                
                VStack (spacing: 4){
                    HStack(spacing: 0){
                        Text("Directorio")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(.white)
                        Text("Volcanes")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(Color("txt"))
                    }
                    Text("Encuentra lo que necesites")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                }
                .padding(.top)
                
                VStack(spacing: 20){
                    CustomTextField(image: "person", placeHolder: "Email", txt: $model.email)
                    CustomTextField(image: "lock", placeHolder: "Password", txt: $model.password)
                }
                .padding(.top)
                
                Button(action: model.login){
                    Text("Login")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 22)
                
                HStack(spacing: 12){
                    Text("¿No tienes una cuenta?")
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Button(action:{model.isSignUp.toggle()}){
                        Text("Registrate")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 25)
                
                
                
                Button(action: model.resetPassword){
                    Text("¿Olvidaste tu contraseña?")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 22)
                
                Divider()
                
                
            }
            
            if model.isLoading{
                LoadingView()
            }
        }
            .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
            .fullScreenCover(isPresented: $model.isSignUp) {
                SignUpView(model: model)
            }
    //        Alerts...
            .alert(isPresented: $model.alert, content: {
                Alert(title: Text("Mensaje"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok")))
        })
        
        
//        .alert(isPresented: $model.isLinkSend){
//            Alert(title: Text("Mensaje"), message: Text("Revisa tu correo"), dismissButton: .destructive(Text("Ok")))
//        }
    }
    
}


struct CustomTextField : View{
    var image: String
    var placeHolder: String
    @Binding var txt : String
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(Color("bottom"))
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(Circle())
            
            ZStack{
                if placeHolder == "Password" || placeHolder == "Confirma"{
                    SecureField(placeHolder, text: $txt)
                }
                else{
                    TextField(placeHolder, text: $txt)
                        .keyboardType(.emailAddress)
                }
            }
                .padding(.horizontal)
                .padding(.leading, 65)
                .frame(height: 60)
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

struct SignUpView: View {
    
    @ObservedObject var model : ModelData
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            VStack{
                ZStack{
                    if UIScreen.main.bounds.height < 750{
                        Image("logoLogin")
                            .resizable()
                            .frame(width: 130, height: 130)
                    } else{
                        Image("logoLogin")
                    }
                }
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(30)
                    .padding(.top)
                
                VStack (spacing: 4){
                    HStack(spacing: 0){
                        Text("Nueva")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(.white)
                        Text("Cuenta")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(Color("txt"))
                    }
                    Text("Crea una nueva cuenta !!!")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                }
                .padding(.top)
                
                VStack(spacing: 20){
                    CustomTextField(image: "person", placeHolder: "Email", txt: $model.email_SignUp)
                    CustomTextField(image: "lock", placeHolder: "Password", txt: $model.password_SignUp)
                    CustomTextField(image: "lock", placeHolder: "Confirma", txt: $model.reEnterPassword)
                }
                .padding(.top)
                
                Button(action: model.signUp){
                    Text("Registrate")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.vertical, 22)
                
                Spacer(minLength: 0)
            }
            
            Button(action: {model.isSignUp.toggle()}){
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            .padding(.trailing)
            .padding(.top, 10)
            
            if model.isLoading{
                LoadingView()
            }
            
        })
        .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
//        Alerts ...
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Mensaje"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok"), action: {
//                si el link se envio cerrar el signupView...
                if model.alertMsg == "Se a enviado una alerta de verificación. Verifica tu Email." {
                    model.isSignUp.toggle()
                    model.email_SignUp = ""
                    model.password_SignUp = ""
                    model.reEnterPassword = ""
                }
            }))
        })
    }
}

//MVVM Model
class ModelData : ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var email_SignUp = ""
    @Published var password_SignUp = ""
    @Published var reEnterPassword = ""
    @Published var isLinkSend = false
    
//    AlertView with TextFields
    
//    Error alerts
    @Published var alert = false
    @Published var alertMsg = ""
    
//    User Status ....
    @AppStorage("log_Status") var status = false
    
//    Loading
    @Published var isLoading = false
    
    func resetPassword(){
        
        let alert = UIAlertController(title: "Recuperar Contraseña", message: "Ingresa tu correo para recuperar tu contraseña", preferredStyle: .alert)
        
        alert.addTextField{ (password) in
            password.placeholder = "Email"
        }
        
        
        let proceed = UIAlertAction(title: "Recuperar", style: .default) { _ in
//            Enviar link de recuperación
            if alert.textFields![0].text! != ""{
                
                withAnimation{
                    self.isLoading.toggle()
                }
                
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (err) in
                    withAnimation{
                        self.isLoading.toggle()
                    }
                    if err != nil{
                        self.alertMsg = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
//                    Alerta de Usuario
                    self.alertMsg = "Se a enviado un link de recuperación a tu correo."
                    self.alert.toggle()
                }
            }
        }
        
//        let proceed = UIAlertAction(title: "Recuperar", style: .default) { ( ) in
//            self.resetEmail = alert.textFields![0].text!
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        //    Presenting
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
    
//    Login
    func login(){
//        Checando que todos los datos son correctos
        if email == "" || password == ""{
            self.alertMsg = "Llena todos los campos"
            self.alert.toggle()
            return
        }
        
        withAnimation{
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            
            withAnimation{
                self.isLoading.toggle()
            }
            
            if err != nil{
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            //        Checando los datos del usuario
            let user = Auth.auth().currentUser
            
            if !user!.isEmailVerified{
                
                self.alertMsg = "Verifica tu correo"
                self.alert.toggle()
                
                //            loggin out
                try! Auth.auth().signOut()
                return
            }
        
        
//        Setting user status as true
        
        withAnimation{
            self.status = true
            }
        }
        
    }
    
//    SignUp
    func signUp(){
//        Checando...
        if email_SignUp == "" || password_SignUp == "" || reEnterPassword == ""{
            self.alertMsg = "LLena todos los campos."
            self.alert.toggle()
            return
        }
        if password_SignUp != reEnterPassword {
            self.alertMsg = "Las contraseña no coincide."
            self.alert.toggle()
            return
        }
        
        withAnimation{
            self.isLoading.toggle()
        }
        
        Auth.auth().createUser(withEmail: email_SignUp, password: password_SignUp) { (result, err) in
            
            withAnimation{
                self.isLoading.toggle()
            }
            
            if err != nil{
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
//            Enviando link de verificación
            result?.user.sendEmailVerification(completion: { (err) in
                if err != nil{
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
//              Alerting user to verify email...
                self.alertMsg = "Se a enviado una alerta de verificación. Verifica tu Email."
                self.alert.toggle()
                
            })
        }
    }
    
//    Log Out
    func logOut(){
        try! Auth.auth().signOut()
        
        withAnimation{
            self.status = false
        }
        
//        Limpiando los datos
        email = ""
        password = ""
        email_SignUp = ""
        password_SignUp = ""
        reEnterPassword = ""
    }
    
    }

//Checkign With Smaller Devices

//Loading View...

//Listo
struct LoadingView : View{
    @State var animation = false
    
    var body: some View{
        VStack{
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color("bottom"), lineWidth: 8)
                .frame(width: 75, height: 75)
                .rotationEffect(.init(degrees: animation ? 360 : 0))
                .padding(50)
        }
        .background(Color.white)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 1)){
                animation.toggle()
            }
        })
        
    }
}
