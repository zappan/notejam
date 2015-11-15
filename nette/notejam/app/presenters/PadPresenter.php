<?php


namespace App\Presenters;

use App\Components\Notes\INotesFactory;
use App\Forms\Pad\DeletePadFormFactory;
use App\Forms\Pad\NewPadFormFactory;
use App\Model\NoteManager;
use App\Model\PadManager;
use App\Forms\Pad\EditPadFormFactory;
use Nette\Application\BadRequestException;


class PadPresenter extends BasePresenter
{

	/** @var PadManager @inject */
	public $padManager;

	/** @var NoteManager @inject */
	public $noteManager;

	/** @var EditPadFormFactory @inject */
	public $editPadFormFactory;

	/** @var DeletePadFormFactory @inject */
	public $deletePadFormFactory;

	/** @var NewPadFormFactory @inject */
	public $newPadFormFactory;

	/** @var INotesFactory @inject */
	public $notesFactory;

	/** @var int */
	private $id;

	/** @var object */
	private $pad;

	/** @var object[] */
	private $notes;

	/**
	 * @return \Nette\Application\UI\Form
	 */
	protected function createComponentEditPadForm()
	{
		$form = $this->editPadFormFactory->create($this->id, $this->pad->name);
		$form->onSuccess[] = function ($form) {
			$this->flashMessage('Pad successfully updated', 'success');
			$form->getPresenter()->redirect('default', ['id' => $this->id]);
		};
		return $form;
	}

	/**
	 * @return \Nette\Application\UI\Form
	 */
	protected function createComponentDeletePadForm()
	{
		$form = $this->deletePadFormFactory->create($this->id);
		$form->onSuccess[] = function ($form) {
			$this->flashMessage('Pad successfully deleted', 'success');
			$form->getPresenter()->redirect('Homepage:');
		};
		return $form;
	}

	/**
	 * @return \Nette\Application\UI\Form
	 */
	protected function createComponentNewPadForm()
	{
		$form = $this->newPadFormFactory->create();
		$form->onSuccess[] = function ($form) {
			$this->flashMessage('Pad successfully created', 'success');
			$form->getPresenter()->redirect('Homepage:');
		};
		return $form;
	}

	/**
	 * @return \App\Components\Notes\Notes
	 */
	protected function createComponentNotes()
	{
		return $this->notesFactory->create($this->notes);
	}


	public function actionDefault($id)
	{
		$this->loadPad($id);
		$this->notes = $this->noteManager->findByPad($id);
	}

	public function renderDefault()
	{
		$this->template->pad = $this->pad;
	}

	public function actionEdit($id)
	{
		$this->loadPad($id);
	}

	public function renderEdit()
	{
		$this->template->pad = $this->pad;
	}

	public function actionDelete($id)
	{
		$this->loadPad($id);
	}

	public function renderDelete()
	{
		$this->template->pad = $this->pad;
	}

	/**
	 * @param int $id
	 * @throws BadRequestException
	 */
	private function loadPad($id)
	{
		$this->id = $id;
		$this->pad = $this->padManager->find($this->id);
		if (!$this->pad) {
			throw new BadRequestException("Pad with given id not found");
		}
	}

}