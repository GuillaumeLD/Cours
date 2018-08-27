import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule} from '@angular/forms';
import { AppComponent } from './app.component';
import { EquipeComponent } from './equipe/equipe.component';
import { EntrepriseService} from './services/entreprise.service';
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent,
    EquipeComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [
    EntrepriseService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
